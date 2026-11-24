#!/usr/bin/env node
 // Checks new or changed reviews before they are published.
//
// Usage: node tools/validate-review.js src/posts/some-review.md [more files...]
//
// Prints one tab-separated line per result:
//   OK     <file>  <title>     the review passed (it may still have warnings)
//   WARN   <file>  <message>   worth a look, but doesn't block publishing
//   ERROR  <file>  <message>   must be fixed before publishing
// Exits with status 1 if there are any errors.

const fs = require("fs");
const path = require("path");
const matter = require("gray-matter");

const POSTS_DIR = path.join(__dirname, "..", "src", "posts");
const SITE_ORIGIN = "https://businessandyandthefeerex.co.nz";
const SITE_HOSTNAME = new URL(SITE_ORIGIN).hostname;

const REQUIRED = [
  "category", "layout", "title", "date", "rating",
  "meal", "country", "region", "city", "address",
];
const RATING_MIN = 1;
const RATING_MAX = 4;
const MIN_BODY_LENGTH = 50;
const INSTRUCTIONS_MARKER = "<!-- BEFORE PUBLISHING THIS REVIEW";

// Compared with the values used in every other post, to catch typos like
// "Manwatu" or "Feliding", and capitalisation differences that would make two
// location pages collide. Remove "suburb" if the "new suburb" warnings get noisy.
const TAXONOMY = ["country", "region", "city", "suburb", "meal"];

const text = (value) =>
  value === null || value === undefined ? "" : String(value).trim();

function loadKnownValues(skip) {
  const known = Object.fromEntries(TAXONOMY.map((field) => [field, new Set()]));
  if (!fs.existsSync(POSTS_DIR)) return known;
  
  for (const name of fs.readdirSync(POSTS_DIR)) {
    if (!name.endsWith(".md")) continue;
    const full = path.resolve(POSTS_DIR, name);
    if (skip.has(full)) continue;
    
    let data;
    try {
      data = matter(fs.readFileSync(full, "utf8")).data;
    } catch {
      continue; // a broken old post shouldn't stop a new one publishing
    }
    for (const field of TAXONOMY) {
      const value = text(data[field]);
      if (value) known[field].add(value);
    }
  }
  return known;
}

function loadReviewSlugs() {
  if (!fs.existsSync(POSTS_DIR)) return new Set();
  return new Set(
    fs.readdirSync(POSTS_DIR)
      .filter((name) => name.endsWith(".md"))
      .map((name) => name.slice(0, -3))
  );
}

function checkLinks(content, reviewSlugs, firstLineNumber) {
  const errors = [];
  let inFence = false;
  let lineNumber = firstLineNumber - 1;

  for (const line of content.split(/\r?\n/)) {
    lineNumber += 1;
    const fence = line.match(/^\s*(```+|~~~+)/);
    if (fence) {
      inFence = !inFence;
      continue;
    }
    if (inFence) continue;

    for (let index = 0; index < line.length; index += 1) {
      if (line[index] !== "[" || (index > 0 && line[index - 1] === "\\")) continue;

      const labelEnd = line.indexOf("]", index + 1);
      if (labelEnd === -1 || line[labelEnd + 1] !== "(") continue;

      let end = labelEnd + 2;
      let depth = 1;
      for (; end < line.length && depth > 0; end += 1) {
        if (line[end] === "\\" && end + 1 < line.length) {
          end += 1;
        } else if (line[end] === "(") {
          depth += 1;
        } else if (line[end] === ")") {
          depth -= 1;
        }
      }

      const fail = (reason) => errors.push(`line ${lineNumber}: link ${reason}`);
      if (depth !== 0) {
        fail("is missing a closing \")\"");
        continue;
      }

      const targetAndTitle = line.slice(labelEnd + 2, end - 1).trim();
      const targetMatch = targetAndTitle.match(
        /^(?:<([^<>]*)>|(\S+))(?:\s+(?:"[^"]*"|'[^']*'|\([^)]*\)))?$/
      );
      if (!targetMatch) {
        fail("has an empty or malformed destination");
        continue;
      }

      const destination = targetMatch[1] ?? targetMatch[2];
      if (/\s/.test(destination)) {
        fail(`has whitespace in its destination "${destination}"`);
        continue;
      }

      try {
        const url = new URL(destination, SITE_ORIGIN);
        if (!["http:", "https:", "mailto:", "tel:"].includes(url.protocol)) {
          fail(`uses an unsupported URL scheme "${url.protocol}"`);
        } else if (
          url.pathname.startsWith("/posts/") &&
          (destination.startsWith("/") ||
            (/^https?:\/\//i.test(destination) && url.hostname === SITE_HOSTNAME))
        ) {
          const reviewPath = url.pathname.match(/^\/posts\/([^/]+)\/?$/);
          let slug = "";
          try {
            slug = reviewPath ? decodeURIComponent(reviewPath[1]) : "";
          } catch {
            fail(`has an invalid review URL "${destination}"`);
            index = end - 1;
            continue;
          }
          if (!slug || !reviewSlugs.has(slug)) {
            fail(`points to a review that does not exist "${destination}"`);
          }
        }
      } catch {
        fail(`has an invalid destination "${destination}"`);
      }
      index = end - 1;
    }
  }

  return errors;
}

function check(file, known, reviewSlugs) {
  const errors = [];
  const warnings = [];
  
  if (!fs.existsSync(file)) {
    return { errors: ["file is missing from disk"], warnings, title: "" };
  }
  
  const raw = fs.readFileSync(file, "utf8");
  const rawLines = raw.split(/\r?\n/);
  if (!/^---[ \t]*\r?\n/.test(raw)) {
    return {
      errors: ["line 1: missing front matter (the file must start with a --- line)"],
      warnings,
      title: "",
    };
  }

  const closingFrontMatterIndex = rawLines.findIndex(
    (line, index) => index > 0 && /^---[ \t]*$/.test(line)
  );
  const frontMatterEndLine = closingFrontMatterIndex === -1
    ? rawLines.length
    : closingFrontMatterIndex + 1;
  const bodyStartLine = frontMatterEndLine + 1;
  const lineForField = (field) => {
    const index = rawLines.findIndex((line, lineIndex) =>
      lineIndex > 0 && lineIndex < frontMatterEndLine &&
      new RegExp(`^\\s*${field}\\s*:`).test(line)
    );
    return index === -1 ? frontMatterEndLine : index + 1;
  };
  const atLine = (line, message) => `line ${line}: ${message}`;
  
  let parsed;
  try {
    parsed = matter(raw);
  } catch (error) {
    const line = error.mark ? error.mark.line + 1 : 1;
    return {
      errors: [atLine(line, `front matter is not valid YAML: ${error.reason || error.message}`)],
      warnings,
      title: "",
    };
  }
  const { data, content } = parsed;
  
  // Required fields
  const missing = REQUIRED.filter((key) => !text(data[key]));
  if (missing.length) {
    errors.push(atLine(
      frontMatterEndLine,
      `add these missing details above this line: ${missing.join(", ")}`
    ));
  }
  
  // The title has to be text, because it becomes the filename and the page title.
  if (text(data.title) && typeof data.title !== "string") {
    errors.push(atLine(
      lineForField("title"),
      `title "${data.title}" is read as a number or date, so put quote marks around it`
    ));
  }
  
  // Date
  if (text(data.date)) {
    const date = data.date instanceof Date ? data.date : new Date(text(data.date));
    const looksRight = data.date instanceof Date || /^\d{4}-\d{2}-\d{2}/.test(text(data.date));
    if (!looksRight || Number.isNaN(date.getTime())) {
      errors.push(atLine(
        lineForField("date"),
        `date "${text(data.date)}" is not a valid yyyy-mm-dd date`
      ));
    } else if (date.getTime() > Date.now() + 2 * 24 * 60 * 60 * 1000) {
      warnings.push(atLine(
        lineForField("date"),
        `date ${date.toISOString().slice(0, 10)} is in the future`
      ));
    }
  }
  
  // Rating
  if (text(data.rating)) {
    const rating = Number(data.rating);
    if (!Number.isInteger(rating) || rating < RATING_MIN || rating > RATING_MAX) {
      errors.push(atLine(
        lineForField("rating"),
        `rating "${text(data.rating)}" should be a whole number from ${RATING_MIN} to ${RATING_MAX}`
      ));
    }
  }
  
  // Website: the site silently shows "has no website" for anything that isn't http(s)
  const website = text(data.website);
  if (website && !/^https?:\/\//i.test(website)) {
    errors.push(atLine(
      lineForField("website"),
      `website "${website}" must start with http:// or https://`
    ));
  }
  
  // Dishes
  if (typeof data.dishes === "string" && data.dishes.trim()) {
    errors.push(atLine(
      lineForField("dishes"),
      "dishes must be a list, with one \"- dish\" per line"
    ));
  } else if (!Array.isArray(data.dishes) || data.dishes.length === 0) {
    errors.push(atLine(lineForField("dishes"), "dishes list is empty"));
  } else if (data.dishes.some((dish) => !text(dish))) {
    const emptyDishIndex = rawLines.findIndex((line, index) =>
      index + 1 >= lineForField("dishes") &&
      index + 1 < frontMatterEndLine &&
      /^\s*-\s*$/.test(line)
    );
    errors.push(atLine(
      emptyDishIndex === -1 ? lineForField("dishes") : emptyDishIndex + 1,
      "dishes has an empty entry (a lone \"-\" line)"
    ));
  }
  
  // Location and meal values compared with the existing posts
  for (const field of TAXONOMY) {
    const value = text(data[field]);
    if (!value || known[field].has(value)) continue;
    
    const sameLetters = [...known[field]].find(
      (existing) => existing.toLowerCase() === value.toLowerCase()
    );
    if (sameLetters) {
      errors.push(atLine(
        lineForField(field),
        `${field} "${value}" differs only in capitalisation from the existing "${sameLetters}"`
      ));
    } else {
      warnings.push(atLine(
        lineForField(field),
        `${field} "${value}" hasn't been used in any other review, check the spelling`
      ));
    }
  }
  
  // Body
  if (content.includes(INSTRUCTIONS_MARKER)) {
    const instructionsLine = content.split(/\r?\n/)
      .findIndex((line) => line.includes(INSTRUCTIONS_MARKER));
    errors.push(atLine(bodyStartLine + instructionsLine, "still contains the writing instructions"));
  } else if (content.trim().length < MIN_BODY_LENGTH) {
    errors.push(atLine(bodyStartLine, "the review text is empty or very short"));
  }
  errors.push(...checkLinks(content, reviewSlugs, bodyStartLine));
  
  return { errors, warnings, title: text(data.title) };
}

const files = process.argv.slice(2).map((file) => path.resolve(file));
if (files.length === 0) {
  console.error("Usage: node tools/validate-review.js <review.md> [more reviews...]");
  process.exit(2);
}

const known = loadKnownValues(new Set(files));
const reviewSlugs = loadReviewSlugs();
const line = (kind, file, message) =>
  console.log([kind, path.basename(file), String(message).replace(/\s+/g, " ")].join("\t"));

let failed = false;
for (const file of files) {
  const { errors, warnings, title } = check(file, known, reviewSlugs);
  errors.forEach((message) => line("ERROR", file, message));
  warnings.forEach((message) => line("WARN", file, message));
  if (errors.length) failed = true;
  else line("OK", file, title);
}

process.exit(failed ? 1 : 0);