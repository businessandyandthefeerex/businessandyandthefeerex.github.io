// Sass is used to compile the existing Alembic theme styles into CSS.
const sass = require("sass");

// Eleventy configuration file: this is where filters, collections, template formats,
// copied files, custom directories, and build behaviour are configured.
module.exports = function (eleventyConfig) {
  // ------------------------------------------------------------            // Custom filters
  // ------------------------------------------------------------

  // 1. Create a cache map and grab the existing slugify filter
  const slugCache = new Map();
  const originalSlugify = eleventyConfig.getFilter("slugify");

  // 2. Override the filter with a memoized wrapper
  eleventyConfig.addFilter("slugify", function(str) {
    if (!str) return "";
    
    // Return cached result if it exists
    if (slugCache.has(str)) {
      return slugCache.get(str);
    }
    
    // Otherwise, compute, cache, and return
    const slug = originalSlugify(str);
    slugCache.set(str, slug);
    return slug;
  });

  // Converts a review date into a readable month and year, for example "November 2020".
  eleventyConfig.addFilter("formatReviewDate", (date) => {
    const value = new Date(date);
    return Number.isNaN(value.getTime())
      ? ""
      : new Intl.DateTimeFormat("en-NZ", {
          month: "long",
          year: "numeric",
          timeZone: "UTC",
        }).format(value);
  });

  // Order taxonomy entries using the optional country configuration in
  // src/_data/locationOrder.js. Any entries omitted from the configured list
  // are appended alphabetically.
  eleventyConfig.addFilter("orderRegions", (regions, country, locationOrder) => {
    const requestedOrder = Array.isArray(locationOrder?.[country])
      ? locationOrder[country]
      : [];
    const byName = new Map(regions.map((region) => [region.name, region]));
    const ordered = [];

    for (const name of requestedOrder) {
      if (byName.has(name)) {
        ordered.push(byName.get(name));
        byName.delete(name);
      }
    }

    const remaining = [...byName.values()].sort((a, b) =>
      a.name.localeCompare(b.name)
    );

    return [...ordered, ...remaining];
  });

  // ------------------------------------------------------------            // Sass stylesheet processing
  // ------------------------------------------------------------

  // Tell Eleventy that .scss files are templates and may produce output files.
  eleventyConfig.addTemplateFormats("scss");

  // Register a custom .scss template extension. Eleventy renders files with the
  // front matter permalink, while the input Sass can import files from _sass.
  eleventyConfig.addExtension("scss", {
    outputFileExtension: "css",
    compile: async function (inputContent) {
      return async () => sass.compileString(inputContent, {
        loadPaths: ["src/_sass"],
        style: "compressed",
      }).css;
    },
  });

  // Only src/styles.scss is an Eleventy stylesheet entry point. Sass partials are
  // imported by that entry point and must not be built as standalone Eleventy files.
  eleventyConfig.ignores.add("src/_sass/**/*.scss");

  // Eleventy does not watch imported Sass directories by default.
  eleventyConfig.addWatchTarget("src/_sass");

  // add a passthrough copy for the CNAME file so that it is copied to the output directory
  eleventyConfig.addPassthroughCopy({ "CNAME": "CNAME" });

  // ------------------------------------------------------------            // Static asset copying
  // ------------------------------------------------------------

  // Copy assets unchanged into the output directory. No Eleventy template
  // processing is applied to these files, making this suitable for images,
  // scripts, fonts, manifests, maps, and other public static files.
  eleventyConfig.addPassthroughCopy({
    assets: "assets",
  });

  eleventyConfig.addPassthroughCopy({ "assets/scripts/sw.js": "sw.js" });

  // ------------------------------------------------------------            // Review collection
  // ------------------------------------------------------------

  // Match every review Markdown file and expose the results to templates as
  // collections.reviews. The reverse() call lists the newest reviews first.
  eleventyConfig.addCollection("reviews", (collectionApi) =>
    collectionApi.getFilteredByGlob("src/posts/**/*.md").reverse()
  );

  // ------------------------------------------------------------            // Flat front matter taxonomy collections
  // ------------------------------------------------------------

  // These collections contain the unique values found in each front matter field.
  // For example, collections.region contains every distinct region value from reviews.
  const taxonomyFields = [
    "category",
    "country",
    "region",
    "city",
    "suburb",
    "meal",
    "rating",
  ];

  // Create one Eleventy collection for every field above. Missing and empty values
  // are ignored, while remaining values are de-duplicated and alphabetically sorted.
  for (const field of taxonomyFields) {
    eleventyConfig.addCollection(field, (collectionApi) => {
      const values = new Set();

      for (const item of collectionApi.getFilteredByGlob("src/posts/**/*.md")) {
        const value = item.data[field];
        if (value !== undefined && value !== "") {
          values.add(String(value));
        }
      }

      return [...values].sort((a, b) => a.localeCompare(b));
    });
  }

  // ------------------------------------------------------------            // Complete country-to-city hierarchy
  // ------------------------------------------------------------

  // Build one nested data structure containing countries, regions, cities, suburbs,
  // and ratings. This collection is currently available to templates, but the three
  // flatter location collections below provide convenient data for pagination pages.
  eleventyConfig.addCollection("locationHierarchy", (collectionApi) => {
    const reviews = collectionApi.getFilteredByGlob("src/posts/**/*.md");
    const normalize = (value) => String(value || "").trim();
    const countries = new Map();

    for (const review of reviews) {
      const countryName = normalize(review.data.country);
      const regionName = normalize(review.data.region);
      const cityName = normalize(review.data.city);
      const suburbName = normalize(review.data.suburb) || "Unlisted suburb";

      // A complete location is required for this hierarchy.
      if (!countryName || !regionName || !cityName) continue;

      if (!countries.has(countryName)) {
        countries.set(countryName, { name: countryName, regions: new Map() });
      }
      const country = countries.get(countryName);

      if (!country.regions.has(regionName)) {
        country.regions.set(regionName, { name: regionName, cities: new Map() });
      }
      const region = country.regions.get(regionName);

      if (!region.cities.has(cityName)) {
        region.cities.set(cityName, { name: cityName, suburbs: new Map() });
      }
      const city = region.cities.get(cityName);

      if (!city.suburbs.has(suburbName)) {
        city.suburbs.set(suburbName, { name: suburbName, ratings: new Map() });
      }
      const suburb = city.suburbs.get(suburbName);
      const ratingName = String(review.data.rating || "Unrated");
      if (!suburb.ratings.has(ratingName)) suburb.ratings.set(ratingName, []);
      suburb.ratings.get(ratingName).push(review);
    }

    // Convert the temporary Map structures into plain arrays so Nunjucks can iterate
    // over them naturally. Values are sorted alphabetically at every location level.
    const hierarchy = [...countries.values()].sort((a, b) => a.name.localeCompare(b.name)).map((country) => {
      const regions = [...country.regions.values()].sort((a, b) => a.name.localeCompare(b.name)).map((region) => ({
        country: country.name,
        name: region.name,
        cities: [...region.cities.values()].sort((a, b) => a.name.localeCompare(b.name)).map((city) => ({
          country: country.name,
          region: region.name,
          name: city.name,
          suburbs: [...city.suburbs.values()].sort((a, b) => a.name.localeCompare(b.name)).map((suburb) => ({
            name: suburb.name,
            ratings: [...suburb.ratings.entries()].sort(([a], [b]) =>
              String(b).localeCompare(String(a), undefined, { numeric: true })
            ).map(([rating, reviews]) => ({
              name: rating,
              reviews,
            })),
          })),
        })),
      }));
      return { name: country.name, regions };
    });

    return hierarchy;
  });

  // ------------------------------------------------------------            // Country pagination data
  // ------------------------------------------------------------

  // Produce one object per country containing the unique regions found under that
  // country. src/locations/countries.njk uses these objects to create an index page,
  // and src/locations/country.njk uses pagination to create one page per country.
  eleventyConfig.addCollection("locationCountries", (collectionApi) => {
    const reviews = collectionApi.getFilteredByGlob("src/posts/**/*.md");
    const countries = new Map();

    for (const review of reviews) {
      const country = String(review.data.country || "").trim();
      if (!country) continue;

      if (!countries.has(country)) {
        countries.set(country, { name: country, regions: new Set() });
      }

      const region = String(review.data.region || "").trim();
      if (region) countries.get(country).regions.add(region);
    }

    const countryPages = [...countries.values()].sort((a, b) => a.name.localeCompare(b.name)).map((country) => ({
      name: country.name,
      regions: [...country.regions].sort((a, b) => a.localeCompare(b)).map((name) => ({ name })),
    }));

    return [{ name: null, regions: countryPages }, ...countryPages];
  });

  // ------------------------------------------------------------            // Region pagination data
  // ------------------------------------------------------------

  // Produce one object for every country-and-region combination, including its cities.
  // A separator in the Map key prevents same-named regions in different countries
  // from being merged accidentally.
  eleventyConfig.addCollection("locationRegions", (collectionApi) => {
    const reviews = collectionApi.getFilteredByGlob("src/posts/**/*.md");
    const regions = new Map();

    for (const review of reviews) {
      const country = String(review.data.country || "").trim();
      const region = String(review.data.region || "").trim();
      const city = String(review.data.city || "").trim();
      if (!country || !region || !city) continue;

      const key = `${country}\u0000${region}`;
      if (!regions.has(key)) regions.set(key, { country, name: region, cities: new Set() });
      regions.get(key).cities.add(city);
    }

    return [...regions.values()].sort((a, b) =>
      `${a.country}\u0000${a.name}`.localeCompare(`${b.country}\u0000${b.name}`)
    ).map((region) => ({
      ...region,
      cities: [...region.cities].sort((a, b) => a.localeCompare(b)).map((name) => ({ name })),
    }));
  });

  // ------------------------------------------------------------            // City pagination and review grouping data
  // ------------------------------------------------------------

  const sortReviewsByTitleAndDate = (reviews) =>
    [...reviews].sort((a, b) => {
      const titleOrder = String(a.data.title || "").localeCompare(
        String(b.data.title || ""),
        undefined,
        { numeric: true, sensitivity: "base" }
      );
      return titleOrder || b.date - a.date;
    });

  eleventyConfig.addCollection("locationCities", (collectionApi) => {
    const slugify = eleventyConfig.getFilter("slugify");
    const cities = new Map();
    const reviews = collectionApi.getFilteredByGlob("src/posts/**/*.md");

    for (const review of reviews) {
      const country = String(review.data.country || "").trim();
      const region = String(review.data.region || "").trim();
      const city = String(review.data.city || "").trim();
      const rawSuburb = String(review.data.suburb || "").trim();
      const suburb = !rawSuburb || rawSuburb === city ? "Unlisted suburb" : rawSuburb;
      if (!country || !region || !city) continue;

      const key = [country, region, city].map(slugify).join("|");
      if (!cities.has(key)) {
        cities.set(key, { country, region, name: city, suburbs: new Map() });
      }

      const cityData = cities.get(key);
      if (!cityData.suburbs.has(suburb)) cityData.suburbs.set(suburb, new Map());

      const rating = String(review.data.rating || "Unrated").trim();
      const ratings = cityData.suburbs.get(suburb);
      if (!ratings.has(rating)) ratings.set(rating, []);
      ratings.get(rating).push(review);
    }

    // Sort by location, then convert suburbs and ratings into arrays because Nunjucks
    // can iterate plain arrays directly. Each city page is populated with matching
    // review objects grouped first by suburb and then by rating.
    const result = [...cities.values()].sort((a, b) =>
      `${a.country}\u0000${a.region}\u0000${a.name}`.localeCompare(`${b.country}\u0000${b.region}\u0000${b.name}`)
    ).map((city) => ({
      ...city,
      suburbs: [...city.suburbs.entries()].sort(([a], [b]) => a.localeCompare(b)).map(([name, ratings]) => ({
        name,
        ratings: [...ratings.entries()].sort(([a], [b]) =>
          b.localeCompare(a, undefined, { numeric: true })
        ).map(([rating, reviews]) => ({
          name: rating,
          reviews: sortReviewsByTitleAndDate(reviews),
        })),
      })),
    })).filter((city, index, cities) => {
      // Remove duplicate location entries that collapse to the same country-region-city URL.
      const location = [city.country, city.region, city.name].map(slugify).join("|");
      const firstIndex = cities.findIndex((candidate) =>
        [candidate.country, candidate.region, candidate.name].map(slugify).join("|") === location
      );
      return firstIndex === index;
    });

    return result;
  });

  // ------------------------------------------------------------            // suburb pagination and review grouping data
  // ------------------------------------------------------------

  // One entry per country/region/city/suburb combination, with its reviews grouped
  // by rating (highest first). Keys use the same slugify as the permalinks, so two
  // names that slugify identically can't produce clashing URLs.
  eleventyConfig.addCollection("locationSuburbs", (collectionApi) => {
    const slugify = eleventyConfig.getFilter("slugify");
    const suburbs = new Map();

    const reviews = collectionApi.getFilteredByGlob("src/posts/**/*.md");

    for (const review of reviews) {
      const country = String(review.data.country || "").trim();
      const region = String(review.data.region || "").trim();
      const city = String(review.data.city || "").trim();
      const name = String(review.data.suburb || "").trim();
      if (!country || !region || !city || !name) continue;
      if (name === city) continue;

      const key = [country, region, city, name].map(slugify).join("|");
      if (!suburbs.has(key)) {
        suburbs.set(key, { country, region, city, name, ratings: new Map() });
      }

      const rating = String(review.data.rating || "Unrated").trim();
      const ratings = suburbs.get(key).ratings;
      if (!ratings.has(rating)) ratings.set(rating, []);
      ratings.get(rating).push(review);
    }

    return [...suburbs.values()]
      .sort((a, b) =>
        `${a.country}\u0000${a.region}\u0000${a.city}\u0000${a.name}`.localeCompare(
          `${b.country}\u0000${b.region}\u0000${b.city}\u0000${b.name}`
        )
      )
      .map((suburb) => ({
        ...suburb,
        ratings: [...suburb.ratings.entries()]
          .sort(([a], [b]) => b.localeCompare(a, undefined, { numeric: true }))
          .map(([name, reviews]) => ({
            name,
            reviews: sortReviewsByTitleAndDate(reviews),
          })),
      }));
  });

  // ------------------------------------------------------------            // Find other reviews for the same restaurant in the same country and region.
  // ------------------------------------------------------------

  // Find other reviews for the same restaurant in the same country and region.
  eleventyConfig.addFilter("relatedReviews", (reviews, currentUrl, title, country, region) =>
    reviews.filter((review) =>
      review.url !== currentUrl &&
      review.data.title === title &&
      review.data.country === country &&
      review.data.region === region
    )
  );

  // Format a review date with its day, month, and year.
  eleventyConfig.addFilter("formatReviewFullDate", (date) => {
    const value = new Date(date);
    return Number.isNaN(value.getTime())
      ? ""
      : new Intl.DateTimeFormat("en-NZ", {
          day: "numeric",
          month: "long",
          year: "numeric",
          timeZone: "UTC",
        }).format(value);
  });

  // ------------------------------------------------------------            // Individual date components for review metadata links
  // ------------------------------------------------------------

  // Formats a date as an ISO 8601 string for use in <time datetime="...">.
  eleventyConfig.addFilter("isoDate", (date) => {
    const value = new Date(date);
    return Number.isNaN(value.getTime()) ? "" : value.toISOString();
  });

  eleventyConfig.addFilter("dateParts", (date) => {
    const value = new Date(date);
    if (Number.isNaN(value.getTime())) return {};
    return {
      day: String(value.getUTCDate()).padStart(2, "0"),
      month: String(value.getUTCMonth() + 1).padStart(2, "0"),
      monthName: new Intl.DateTimeFormat("en-NZ", {
        month: "long",
        timeZone: "UTC",
      }).format(value),
      year: String(value.getUTCFullYear()),
    };
  });

  // Build the canonical date tree: years contain months, months contain days,
  // and day leaves contain reviews sorted newest first.
  const buildDateHierarchy = (reviews) => {
    const pad = (value) => String(value).padStart(2, "0");
    const monthFormatter = new Intl.DateTimeFormat("en-NZ", {
      month: "long",
      timeZone: "UTC",
    });
    const years = new Map();
    const sortedReviews = [...reviews].sort((a, b) => b.date - a.date);

    for (const review of sortedReviews) {
      const date = review.date;
      const year = String(date.getUTCFullYear());
      const month = pad(date.getUTCMonth() + 1);
      const day = pad(date.getUTCDate());
      const dayNumber = String(date.getUTCDate());
      const monthName = monthFormatter.format(date);
      const dayKey = `${year}-${month}-${day}`;

      if (!years.has(year)) {
        years.set(year, {
          key: year,
          year,
          path: `/year/${year}/`,
          months: new Map(),
        });
      }
      const yearNode = years.get(year);

      if (!yearNode.months.has(month)) {
        yearNode.months.set(month, {
          key: `${year}-${month}`,
          year,
          month,
          monthName,
          title: `${monthName} ${year}`,
          path: `/year/${year}/month/${month}/`,
          days: new Map(),
        });
      }
      const monthNode = yearNode.months.get(month);

      if (!monthNode.days.has(day)) {
        monthNode.days.set(day, {
          key: dayKey,
          year,
          month,
          monthName,
          day: dayNumber,
          dayPadded: day,
          title: `${dayNumber} ${monthName} ${year}`,
          path: `/year/${year}/month/${month}/day/${day}/`,
          reviews: [],
        });
      }
      monthNode.days.get(day).reviews.push(review);
    }

    return [...years.values()]
      .sort((a, b) => b.key.localeCompare(a.key))
      .map((year) => ({
        ...year,
        months: [...year.months.values()]
          .sort((a, b) => b.key.localeCompare(a.key))
          .map((month) => ({
            ...month,
            days: [...month.days.values()].sort((a, b) => b.key.localeCompare(a.key)),
          })),
      }));
  };

  const getDateHierarchy = (collectionApi) =>
    buildDateHierarchy(collectionApi.getFilteredByGlob("src/posts/**/*.md"));

  eleventyConfig.addCollection("dateHierarchy", getDateHierarchy);
  eleventyConfig.addCollection("dateYears", (collectionApi) => {
    const years = getDateHierarchy(collectionApi);
    return [{ year: null, path: "/year/", years }, ...years];
  });
  eleventyConfig.addCollection("dateMonths", (collectionApi) =>
    getDateHierarchy(collectionApi).flatMap((year) => year.months)
  );
  eleventyConfig.addCollection("dateDays", (collectionApi) =>
    getDateHierarchy(collectionApi).flatMap((year) =>
      year.months.flatMap((month) => month.days)
    )
  );

  // ------------------------------------------------------------            // Compare taxonomy values without treating YAML numbers and strings differently.
  eleventyConfig.addFilter("sameValue", (left, right) =>
    String(left ?? "") === String(right ?? "")
  );

  // ------------------------------------------------------------            // validwebsite filter
  // ------------------------------------------------------------

  // Returns the URL if it is a usable http(s) address
  // otherwise an empty string so the template falls through to 
  // the "has no website" branch.
  eleventyConfig.addFilter("validWebsite", (url) => {
    if (typeof url !== "string" || !url.trim()) return "";
    const value = url.trim();
    try {
      const parsed = new URL(value);
      return ["http:", "https:"].includes(parsed.protocol) ? value : "";
    } catch {
      return "";
    }
  });

  // ------------------------------------------------------------            // Eleventy directory configuration
  // ------------------------------------------------------------

  // src is the source directory, including layouts, includes, and global data.
  // Eleventy writes generated files separately to _site-eleventy so the existing
  // Jekyll output remains untouched during migration.
  return {
    dir: { input: "src"},
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
  };
};