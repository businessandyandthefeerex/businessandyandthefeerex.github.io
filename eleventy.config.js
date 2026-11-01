// Sass is used to compile the existing Alembic theme styles into CSS.
const sass = require("sass");

// Eleventy configuration file: this is where filters, collections, template formats,
// copied files, custom directories, and build behaviour are configured.
module.exports = function (eleventyConfig) {
  // ------------------------------------------------------------            // Custom filters
  // ------------------------------------------------------------

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
        loadPaths: ["_sass"],
        style: "compressed",
      }).css;
    },
  });

  // Eleventy does not otherwise watch a Sass include directory during --serve,
  // so changes in _sass explicitly trigger a rebuild and stylesheet recompilation.
  eleventyConfig.addWatchTarget("_sass");

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
          reviews,
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

    const reviews = collectionApi
      .getFilteredByGlob("src/posts/**/*.md")
      .sort((a, b) => b.date - a.date);

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
          .map(([name, reviews]) => ({ name, reviews })),
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

  // Groups reviews into years, each containing months, each containing reviews.
  // Everything is sorted newest first, and each year and month carries the URL of
  // its archive page.
  eleventyConfig.addFilter("groupByYearMonth", (reviews) => {
    const monthFormatter = new Intl.DateTimeFormat("en-NZ", {
      month: "long",
      timeZone: "UTC",
    });
    const sorted = [...reviews].sort((a, b) => b.date - a.date);
    const years = [];

    for (const review of sorted) {
      const d = review.date;
      const year = String(d.getUTCFullYear());
      const month = String(d.getUTCMonth() + 1).padStart(2, "0");

      let yearGroup = years[years.length - 1];
      if (!yearGroup || yearGroup.year !== year) {
        yearGroup = { year, path: `/reviews/${year}/`, months: [] };
        years.push(yearGroup);
      }

      let monthGroup = yearGroup.months[yearGroup.months.length - 1];
      if (!monthGroup || monthGroup.month !== month) {
        monthGroup = {
          month,
          name: monthFormatter.format(d),
          path: `/reviews/${year}/${month}/`,
          reviews: [],
        };
        yearGroup.months.push(monthGroup);
      }

      monthGroup.reviews.push(review);
    }

    return years;
  });

  // Groups reviews (already sorted newest first) into consecutive month buckets,
  // each with a heading name and a link to that month's archive page.
  eleventyConfig.addFilter("groupByMonth", (reviews) => {
    const formatter = new Intl.DateTimeFormat("en-NZ", {
      month: "long",
      timeZone: "UTC",
    });
    const groups = [];

    for (const review of reviews) {
      const d = review.date;
      const name = formatter.format(d);
      const month = String(d.getUTCMonth() + 1).padStart(2, "0");
      let group = groups[groups.length - 1];

      if (!group || group.name !== name) {
        group = {
          name,
          path: `/reviews/${d.getUTCFullYear()}/${month}/`,
          reviews: [],
        };
        groups.push(group);
      }
      group.reviews.push(review);
    }

    return groups;
  });

  // One entry per year, month and day that contains reviews. Each entry carries
  // its URL path, a display title and its reviews (newest first), so date.njk can
  // render every level of archive page.
  eleventyConfig.addCollection("dateArchives", (collectionApi) => {
    const pad = (n) => String(n).padStart(2, "0");
    const monthFormatter = new Intl.DateTimeFormat("en-NZ", {
      month: "long",
      timeZone: "UTC",
    });
    const archives = new Map();

    const reviews = collectionApi
      .getFilteredByGlob("src/posts/**/*.md")
      .sort((a, b) => b.date - a.date);

    for (const review of reviews) {
      const d = review.date;
      const year = String(d.getUTCFullYear());
      const month = pad(d.getUTCMonth() + 1);
      const day = pad(d.getUTCDate());
      const monthName = monthFormatter.format(d);

      const levels = [
        { key: year, path: `/reviews/${year}/`, title: year },
        {
          key: `${year}-${month}`,
          path: `/reviews/${year}/${month}/`,
          title: `${monthName} ${year}`,
        },
        {
          key: `${year}-${month}-${day}`,
          path: `/reviews/${year}/${month}/${day}/`,
          title: `${Number(day)} ${monthName} ${year}`,
        },
      ];

      for (const level of levels) {
        if (!archives.has(level.key)) {
          archives.set(level.key, { ...level, reviews: [] });
        }
        archives.get(level.key).reviews.push(review);
      }
    }

    return [...archives.values()].sort((a, b) => b.key.localeCompare(a.key));
  });

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
    dir: {
      input: "src",
      includes: "_includes",
      layouts: "_layouts",
      data: "_data",
      output: "_site-eleventy",
    },
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
  };
};