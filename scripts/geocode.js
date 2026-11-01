const fs = require("fs");
const path = require("path");
const matter = require("gray-matter");

const API_KEY = process.env.LOCATIONIQ_KEY;
const POSTS_DIR = "src/posts";
const OUTPUT_FILE = "assets/geocoded_locations.json";
const DELAY_MS = 2000; // LocationIQ free tier rate limit

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

// Strip macrons and other accents, then drop anything still non-ASCII.
const normalizeString = (str) =>
  str
    .normalize("NFKD")
    .replace(/\p{Mn}/gu, "")
    .replace(/[^\x00-\x7F]/g, "");

const locationKey = (address, country) => `${address}|${country}`;

async function geocodeAddress(address, country) {
  const query = normalizeString(`${address}, ${country}`);
  const url = new URL("https://us1.locationiq.com/v1/search");
  url.search = new URLSearchParams({ key: API_KEY, q: query, format: "json" });

  try {
    const res = await fetch(url, { signal: AbortSignal.timeout(10000) });
    if (!res.ok) {
      console.log(`API Error: ${res.status} ${res.statusText}`);
      return null;
    }
    const data = await res.json();
    if (!Array.isArray(data) || data.length === 0) return null;
    return { lat: data[0].lat, lon: data[0].lon };
  } catch (error) {
    console.log(`Error geocoding ${query}: ${error.message}`);
    return null;
  }
}

const save = (entries) =>
  fs.writeFileSync(OUTPUT_FILE, JSON.stringify(entries, null, 2));

// Same rule as the Ruby script: one entry per address + country + title.
function dedupe(entries) {
  const norm = (s) => String(s ?? "").trim().toLowerCase().replace(/\s+/g, " ");
  const seen = new Set();
  return entries.filter((entry) => {
    const key = [entry.address, entry.country, entry.title].map(norm).join("|");
    if (seen.has(key)) {
      console.log(`Removing duplicate: ${entry.title} (${entry.address})`);
      return false;
    }
    seen.add(key);
    return true;
  });
}

async function main() {
  if (!API_KEY) {
    console.error("Set LOCATIONIQ_KEY (see .env) before running.");
    process.exit(1);
  }

  let entries = fs.existsSync(OUTPUT_FILE)
    ? JSON.parse(fs.readFileSync(OUTPUT_FILE, "utf8"))
    : [];
  const known = new Set(entries.map((e) => locationKey(e.address, e.country)));

  // Sorted so the oldest review of a location is the one that gets recorded.
  const files = fs.readdirSync(POSTS_DIR).filter((f) => f.endsWith(".md")).sort();

  for (const [index, file] of files.entries()) {
    const { data } = matter(fs.readFileSync(path.join(POSTS_DIR, file), "utf8"));
    const { address, country, title } = data;
    const rating = data.rating ?? "No rating";

    if (!address || !country) continue;

    console.log(`Processing post ${index + 1}/${files.length}: ${file}`);

    if (known.has(locationKey(address, country))) {
      console.log(`Skipping previously processed location: ${address}, ${country}`);
      continue;
    }

    console.log(`Geocoding: ${address}, ${country}`);
    const location = await geocodeAddress(address, country);

    if (location) {
      entries.push({ file, address, country, ...location, title, rating });
      known.add(locationKey(address, country));
      save(entries); // saved as we go, so a crash doesn't lose progress
    } else {
      console.log(`Failed to geocode: ${address}, ${country}`);
    }

    await sleep(DELAY_MS);
  }

  entries = dedupe(entries);
  save(entries);
  console.log(`Done. ${entries.length} entries saved to ${OUTPUT_FILE}.`);
}

main();