(function () {
  var map = L.map("map").setView([-41.3, 174.8], 6); // 6 shows most of NZ; use 13 for a close Wellington view

  L.tileLayer("https://api.maptiler.com/maps/streets-v2/256/{z}/{x}/{y}.png?key=TBMEHjpwUqAgqKJFiXYL", {
    attribution: '<a href="https://www.openstreetmap.org">OpenStreetMap</a> | <a href="https://www.maptiler.com">MapTiler</a>',
    maxZoom: 19,
  }).addTo(map);

  var esc = function (s) {
    return String(s).replace(/[&<>"']/g, function (c) {
      return { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c];
    });
  };

  fetch("/assets/markers.json")
    .then(function (response) { return response.json(); })
    .then(function (markersData) {
      markersData.forEach(function (marker) {
        var lat = marker.lat;
        var lon = marker.lon;

        // Shift Cook Islands longitudes so they sit next to NZ on the map.
        if (lat > -50 && lat < 0 && lon < -150) { lon += 360; }

        var safeLink = String(marker.link).replace(/'/g, "%27");

        var popupContent =
          "<strong>" + esc(marker.title) + "</strong><br>" +
          "Rating: " + esc(marker.rating) + "<br>" +
          esc(marker.address) + "<br>" +
          "<a href='" + safeLink + "' target='_blank'>View Post</a>";

        L.marker([lat, lon]).bindPopup(popupContent).addTo(map);
      });
    })
    .catch(function (error) { console.error("Error loading markers data:", error); });
})();