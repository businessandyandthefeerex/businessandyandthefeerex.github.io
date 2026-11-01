const fs = require("fs");
const path = require("path");
const { execFileSync } = require("child_process");
const matter = require("gray-matter");

const POSTS_DIR = "src/posts";
const dryRun = process.argv.includes("--dry-run");

const sanitize = (title) =>
  title
    .trim()
    .replace(/&/g, "and")
    .replace(/[<>"']/g, "")
    .replace(/\s+/g, "-")
    .replace(/-+/g, "-")
    .replace(/[^a-zA-Z0-9-]/g, "")
    .toLowerCase();

// gray-matter parses "2021-05-07" as a UTC-midnight Date, so read it in UTC.
function formatDate(value) {
  if (value instanceof Date && !Number.isNaN(value.getTime())) {
    return value.toISOString().slice(0, 10);
  }
  const match = String(value ?? "").match(/^\d{4}-\d{2}-\d{2}/);
  return match ? match[0] : null;
}

// Use git mv for tracked files so the rename is staged as a rename.
function rename(from, to) {
  try {
    execFileSync("git", ["ls-files", "--error-unmatch", from], { stdio: "ignore" });
    execFileSync("git", ["mv", from, to]);
  } catch {
    fs.renameSync(from, to);
  }
}

const files = fs.readdirSync(POSTS_DIR).filter((f) => f.endsWith(".md"));
console.log(`Checking filenames for ${files.length} posts`);

for (const filename of files) {
  const file = path.join(POSTS_DIR, filename);
  const { data } = matter(fs.readFileSync(file, "utf8"));

  const date = formatDate(data.date);
  if (!date) {
    console.log(`No date found in front matter for ${filename}, skipping`);
    continue;
  }

  const title = typeof data.title === "string" ? data.title : "";
  if (!title.trim()) {
    console.log(`No title found in front matter for ${filename}, skipping`);
    continue;
  }

  const newFilename = `${date}-${sanitize(title)}.md`;
  if (filename === newFilename) continue;

  const newFile = path.join(POSTS_DIR, newFilename);
  if (fs.existsSync(newFile) && filename.toLowerCase() !== newFilename.toLowerCase()) {
    console.log(`'${newFilename}' already exists. Skipping rename of '${filename}'`);
    continue;
  }

  console.log(`${dryRun ? "Would rename" : "Renamed"} '${filename}' to '${newFilename}'`);
  if (!dryRun) rename(file, newFile);
}