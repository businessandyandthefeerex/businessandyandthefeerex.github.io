const fs = require("fs");

const INPUT_FILE = "assets/geocoded_locations.json";
const OUTPUT_FILE = "assets/markers.json";

if (!fs.existsSync(INPUT_FILE)) {
  console.error(`${INPUT_FILE} not found. Run "npm run geocode" first.`);
  process.exit(1);
}

const locations = JSON.parse(fs.readFileSync(INPUT_FILE, "utf8"));

// Post file "2020-11-07-cafe-huhu.md" lives at /posts/2020-11-07-cafe-huhu/.
const postUrl = (file) =>
  /^\d{4}-\d{2}-\d{2}-.+\.md$/.test(file)
    ? `/posts/${file.replace(/\.md$/, "")}/`
    : "#";

const markers = locations.map((location) => ({
  lat: Number(location.lat),
  lon: Number(location.lon),
  title: location.title,
  address: `${location.address}, ${location.country}`,
  rating: String(location.rating ?? "No rating"),
  link: postUrl(location.file),
}));

// Deduplicate by lat, lon and title, as before.
const seen = new Set();
const unique = markers.filter((marker) => {
  const key = [marker.lat, marker.lon, marker.title].join("|");
  if (seen.has(key)) return false;
  seen.add(key);
  return true;
});

fs.writeFileSync(OUTPUT_FILE, JSON.stringify(unique, null, 2));
console.log(`Wrote ${unique.length} markers to ${OUTPUT_FILE}.`);