---
title: Browse a Map
permalink: /map/
---
All the restaurants we've reviewed as pins on a map.

<!-- Map container -->
<div id="map" style="width: 100%; height: 500px;"></div>

<!-- Leaflet CSS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />

<!-- Leaflet JS -->
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>

<!-- Leaflet Marker Cluster -->
<script src="https://unpkg.com/leaflet.markercluster@1.4.1/dist/leaflet.markercluster.js"></script>

<script src="https://unpkg.com/js-yaml/dist/js-yaml.min.js"></script>

<script>
    // Initialize the map with a default view
    var map = L.map('map').setView([-41, 173], 5); // New Zealand's approximate latitude and longitude, with a suitable zoom level

    // MapTiler Streets v2 Tile Layer URL
    L.tileLayer('https://api.maptiler.com/maps/streets-v2/256/{z}/{x}/{y}.png?key=TBMEHjpwUqAgqKJFiXYL', {
        maxZoom: 19
    }).addTo(map);

    // Fetch markers data from the assets folder
    fetch('{{ "/assets/markers.yml" | relative_url }}')
        .then(response => response.text())  // Get the text content of the file
        .then(yamlText => {
            // Parse the YAML data into a JavaScript object
            var markersData = jsyaml.load(yamlText);

            // Loop through markersData and add each marker to the map
            markersData.forEach(function(marker) {
                var lat = marker.lat;
                var lon = marker.lon;
                var title = marker.title;
                var address = marker.address;
                var rating = marker.rating;
                var link = marker.link;

                // Ensure that the link is properly escaped
                var safeLink = link.replace(/'/g, '%27');  // Escape single quotes in the URL

                // Create a marker for each location
                var popupContent = "<strong>" + title + "</strong><br>" +
                                   "Rating: " + rating + "<br>" +
                                   address + "<br>" +
                                   "<a href='" + safeLink + "' target='_blank'>View Post</a>";

                var newMarker = L.marker([lat, lon]).bindPopup(popupContent);
                newMarker.addTo(map); // Directly add the marker to the map
            });
        })
        .catch(error => console.error("Error loading markers data:", error));
</script>
