(function () {
  const searchForm = document.querySelector("#search-form");
  const searchField = document.querySelector("#search");
  const resultsBody = document.querySelector("#search-results");
  const status = document.querySelector("#search-status");
  const filterFields = ["country", "region", "city", "suburb", "meal", "rating"];
  const filterPluralLabels = {
    country: "countries",
    region: "regions",
    city: "cities",
    suburb: "suburbs",
    meal: "meals",
    rating: "ratings",
  };
  const locationDescendants = {
    country: ["region", "city", "suburb"],
    region: ["city", "suburb"],
    city: ["suburb"],
    suburb: [],
  };
  let pages = [];

  const escapeHtml = (text) =>
    String(text).replace(/[&<>"']/g, (c) => ({
      "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;",
    }[c]));

  function filterValue(item, field) {
    if (field === "rating" || field === "meal") {
      return String(item[field] || "").replace(/^[^:]+:\s*/, "");
    }
    return String(item[field] || "");
  }

  function getMatches(excludedFields = []) {
    const excluded = new Set(excludedFields);
    const term = searchField.value.trim().toLocaleLowerCase();

    return pages.filter((item) =>
      matchesSearch(item, term) && filterFields.every((field) => {
        if (excluded.has(field)) return true;
        const selected = searchForm.querySelector(`[data-filter="${field}"]`).value;
        return !selected || filterValue(item, field) === selected;
      })
    );
  }

  function updateFilters() {
    for (const field of filterFields) {
      const select = searchForm.querySelector(`[data-filter="${field}"]`);
      const selected = select.value;
      const ignored = [field, ...(locationDescendants[field] || [])];
      const values = [...new Set(getMatches(ignored).map((item) => filterValue(item, field)).filter(Boolean))];

      if (selected && !values.includes(selected)) values.push(selected);
      values.sort((a, b) => a.localeCompare(b, undefined, { numeric: true }));

      select.replaceChildren(new Option(`All ${filterPluralLabels[field]}`, ""));
      for (const value of values) {
        select.add(new Option(value, value, false, value === selected));
      }
    }
  }

  function getResults() {
    return getMatches().sort((a, b) => new Date(b.date) - new Date(a.date));
  }

  function matchesSearch(item, term) {
    if (!term) return true;

    const terms = term.split(/\s+/).filter(Boolean);
    const searchable = [
      item.title, item.content, item.country, item.region, item.city,
      item.suburb, item.address, item.rating, item.meal, item.month,
      item.year, item.month_year, ...(Array.isArray(item.dishes) ? item.dishes : []),
    ].join(" ").toLocaleLowerCase();

    return terms.every((word) => searchable.includes(word));
  }

  function renderResults() {
    const results = getResults();
    status.textContent = `Showing ${results.length} of ${pages.length} reviews`;

    if (results.length === 0) {
      resultsBody.innerHTML = "<li>No reviews match these filters.</li>";
      return;
    }

    resultsBody.innerHTML = results.map((item) => {
      const date = new Date(item.date).toLocaleDateString("en-NZ", {
        month: "long", year: "numeric", timeZone: "UTC",
      });
      const rating = filterValue(item, "rating");

      return `<li>
        <a href="${escapeHtml(item.url)}">${escapeHtml(item.title)}</a>
        ${escapeHtml(date)}${rating ? `, Rating: ${escapeHtml(rating)}` : ""}
      </li>`;
    }).join("");
  }

  function refresh() {
    updateFilters();
    renderResults();
  }

  function handleFilterChange(event) {
    const changedField = event.target.dataset.filter;
    for (const descendant of locationDescendants[changedField] || []) {
      searchForm.querySelector(`[data-filter="${descendant}"]`).value = "";
    }
    refresh();
  }

  function handleReset() {
    requestAnimationFrame(refresh);
  }

  function setupEvents() {
    searchField.addEventListener("input", refresh);
    searchForm.addEventListener("submit", (event) => event.preventDefault());
    searchForm.addEventListener("change", handleFilterChange);
    searchForm.addEventListener("reset", handleReset);
  }

  function loadSearchData() {
    fetch("/assets/search.json")
      .then((response) => {
        if (!response.ok) throw new Error(`Search data request failed: ${response.status}`);
        return response.json();
      })
      .then((data) => {
        pages = data;
        refresh();
      })
      .catch((error) => {
        console.error("Error loading search data:", error);
        status.textContent = "Reviews could not be loaded.";
        resultsBody.innerHTML = "<li>Please try reloading the page.</li>";
      });
  }

  setupEvents();
  loadSearchData();
})();
