const fs = require("fs");
const path = require("path");

const dir = "src/posts";
const apply = process.argv.includes("--apply");

for (const file of fs.readdirSync(dir).filter((f) => f.endsWith(".md"))) {
  const full = path.join(dir, file);
  const text = fs.readFileSync(full, "utf8");
  const match = text.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n([\s\S]*)$/);
  if (!match) continue;

  const [, frontMatter, rawBody] = match;
  if (/^dishes:/m.test(frontMatter)) continue; // already migrated

  const body = rawBody.replace(/^\s*\n/, "");
  const split = body.search(/\r?\n[ \t]*\r?\n/);
  const block = split === -1 ? body : body.slice(0, split);
  const rest = split === -1 ? "" : body.slice(split).replace(/^\s+/, "");

  const lines = block.split(/\r?\n/).map((l) => l.trim()).filter(Boolean);

  // Dishes are short lines. A long line suggests this post has no dish list.
  if (!lines.length || lines.some((l) => l.length > 100)) {
    console.log(`SKIP     ${file}`);
    continue;
  }

  console.log(`${apply ? "UPDATE" : "WOULD  "}  ${file}: ${lines.join(" | ")}`);

  if (apply) {
    const tidy = (s) => s.replace(/:\s+/g, " - ").replace(/:$/, "");
    // Quote a dish only when plain YAML would misread it.
    const needsQuotes = (s) =>
      /^[\s\-?:,\[\]{}#&*!|>'"%@`]/.test(s) || // starts with a special character
      /:(\s|$)/.test(s) ||                     // "key: value" look, or trailing colon
      /\s#/.test(s) ||                         // would start a comment
      /^(true|false|yes|no|on|off|null|~)$/i.test(s) ||
      /^[-+]?[\d.,_:]+$/.test(s);              // looks like a number

    const list = lines
      .map(tidy)
      .map((l) => `  - ${needsQuotes(l) ? JSON.stringify(l) : l}`)
      .join("\n");

    fs.writeFileSync(
      full,
      `---\n${frontMatter}\ndishes:\n${list}\n---\n\n${rest}`
    );
  }
}