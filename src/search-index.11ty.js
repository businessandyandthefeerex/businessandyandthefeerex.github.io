// Builds /assets/search.json from every review, for the client-side search page.
module.exports = class {
  data() {
    return {
      permalink: "/assets/search.json",
      eleventyExcludeFromCollections: true,
    };
  }

  render(data) {
    const monthFormatter = new Intl.DateTimeFormat("en-NZ", {
      month: "long",
      timeZone: "UTC",
    });

    // Crude plain-text version of the markdown body for keyword matching.
    const toText = (raw = "") =>
      raw
        .replace(/^---[\s\S]*?---/, "")
        .replace(/<[^>]+>/g, " ")
        .replace(/[*_#>`\[\]()]/g, "")
        .replace(/\s+/g, " ")
        .trim();

    const entries = data.collections.reviews
      .filter((review) => review.data.category === "Reviews")
      .map((review) => {
        const d = review.date;
        const month = monthFormatter.format(d);
        const year = String(d.getUTCFullYear());
        const rating = String(review.data.rating ?? "").trim();
        const meal = String(review.data.meal ?? "").trim();

        return {
          title: String(review.data.title ?? ""),
          url: review.url,
          date: d.toISOString(),
          content: toText(review.rawInput),
          country: String(review.data.country ?? ""),
          region: String(review.data.region ?? ""),
          city: String(review.data.city ?? ""),
          suburb: String(review.data.suburb ?? ""),
          address: String(review.data.address ?? ""),
          rating: rating ? `Rating: ${rating}` : "",
          meal: meal ? `Meal: ${meal}` : "",
          month,
          year,
          month_year: `${month} ${year}`,
        };
      });

    return JSON.stringify(entries);
  }
};