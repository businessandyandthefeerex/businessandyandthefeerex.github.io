(function () {
  const pages = [];
  const field = document.querySelector("#search");
  const resultsList = document.querySelector("#list");

  fetch("/assets/search.json")
    .then((response) => response.json())
    .then((data) => pages.push(...data))
    .catch((error) => console.error("Error loading search data:", error));

  const escapeRegex = (text) => text.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const escapeHtml = (text) =>
    text.replace(/[&<>"']/g, (c) => ({
      "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;",
    }[c]));

  function findResults(term) {
    // Escaped so typing "(" or "?" doesn't throw an invalid-regex error.
    const regex = new RegExp(escapeRegex(term), "i");
    const fields = [
      "title", "content", "country", "region", "city", "suburb",
      "address", "rating", "meal", "month", "year", "month_year",
    ];
    return pages.filter((item) =>
      fields.some((name) => item[name] && regex.test(item[name]))
    );
  }

  function displayResults() {
    const term = field.value.trim();
    if (!term) {
      resultsList.innerHTML = "";
      return;
    }

    const results = findResults(term).sort((a, b) =>
      a.title.localeCompare(b.title)
    );

    if (results.length === 0) {
      resultsList.innerHTML = "<p>Sorry, nothing was found</p>";
      return;
    }

    resultsList.innerHTML = `
      <ul class="typeset">
        ${results.map((item) => `
          <li>
            <a href="${item.url}">${escapeHtml(item.title)}</a>
            <div class="meta-info" style="font-style: italic; color: #a8adac; font-size: 0.9em; margin-top: 6px;">
              <span class="date">${new Date(item.date).toLocaleDateString("en-GB", {
                day: "numeric", month: "long", year: "numeric", timeZone: "UTC",
              })}${item.rating ? "," : ""}</span>
              ${item.rating ? `<span class="rating">${escapeHtml(item.rating)}</span>` : ""}
            </div>
          </li>`).join("")}
      </ul>`;
  }

  field.addEventListener("input", displayResults);
  field.addEventListener("keydown", (event) => {
    if (event.key === "Enter") event.preventDefault();
  });
})();
