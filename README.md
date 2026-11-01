# Business Andy and The Fee-Rex

Source for businessandyandthefeerex.co.nz, a restaurant review blog. It is built with [Eleventy](https://www.11ty.dev/) (v3), served by GitHub Pages, and the styles come from the Alembic theme's Sass.

## Local development

You need Node 22 or newer (the geocoding script uses Node's built-in `--env-file` support).

```sh
npm install
npm run 11ty:build    # one-off build into _site/
npm run 11ty:serve    # dev server with live reload, http://localhost:8080
```

Eleventy rebuilds as files change. The Sass in `src/_sass` is compiled to `/assets/styles.css` by `src/styles.scss`.

## Project layout

```
.
├── assets/               Static files copied as-is to /assets (images, logos, browser scripts, map data)
│   └── scripts/          Browser JavaScript: search.js, subscribe.js, map.js, sw.js
├── src/                  Everything that becomes the site (Eleventy's input folder)
│   ├── _data/            Global data (site.js, locationOrder.js)
│   ├── _includes/        Layouts and partials (base, page, post, header, footer)
│   ├── _sass/            Theme Sass, imported by styles.scss
│   ├── archives/         Paginated browse pages: date, rating, meal, category, and country/region/city/suburb
│   ├── posts/            One Markdown file per review
│   └── *.njk, *.md       Top-level pages (home, reviews, regions, map, search, subscribe, thanks, 404, latest)
├── tools/                Node scripts run on your machine, never published
├── .githooks/            Versioned git hooks
└── eleventy.config.js    Filters, collections, Sass handling and passthrough copies
```

Rule of thumb: `src/_includes` is for shared partials, `assets/scripts` is for JavaScript that runs in the visitor's browser, and `tools/` is for scripts that run on your computer.

## Adding a review

Create a file in `src/posts/` named `yyyy-mm-dd-restaurant-name.md`. The filename becomes the page URL (`/posts/yyyy-mm-dd-restaurant-name/`), so keep it tidy. The `fix-filenames` tool (below) renames files to match the date and title automatically.

If in doubt, copy an existing post and overwrite the values. The front matter, between the two `---` lines, drives everything:

```yaml
---
category: Reviews
layout: post
title: Little Savanna
date: 2026-10-22
rating: 3
meal: dinner
country: New Zealand
region: Manawatu
city: Palmerston North
suburb: Palmerston North Central
address: 1 Example Street, Palmerston North Central, Palmerston North 4410
website: http://www.littlesavanna.co.nz/
dishes:
  - Biltong
  - Pork belly flatbread
---

Review text starts here.
```

Notes:

- `dishes` is a YAML list. Quote an item only if it contains `: ` or starts with a special character. A ` - ` inside a dish is fine without quotes.
- `suburb` is optional. Leave it out for small towns, or if it would just repeat the city.
- Posts are filed automatically by date, rating, meal, category and location. The Browse by Region pages, date archives and the map all update from the front matter, so there are no index pages to maintain by hand.
- A new region or country gets its pages automatically, because they are generated from the posts by collections in `eleventy.config.js`.

## The map

The map page reads `assets/markers.json`, which is built from `assets/geocoded_locations.json`. Two scripts in `tools/` produce those files:

```sh
npm run geocode     # looks up any addresses not already in geocoded_locations.json (needs the API key)
npm run markers     # rebuilds markers.json from geocoded_locations.json (offline, instant)
```

Geocoding uses [LocationIQ](https://locationiq.com/). Put your key in a `.env` file in the repo root (it is git-ignored):

```
LOCATIONIQ_KEY=your-key-here
```

`geocoded_locations.json` is a cache, keyed on address and country, and it is committed to the repository because the deploy build has no API key. If an address was geocoded wrongly, correct the post and delete the bad entry from the JSON by hand.

## Search

`src/search-index.11ty.js` generates `/assets/search.json` from every review (title, body, dishes, location, rating, meal, date). `assets/scripts/search.js` fetches it and filters in the browser.

## Pre-commit hook

The hook is `.githooks/pre-commit`. Enable it once per clone from the repository root:

```sh
git config core.hooksPath .githooks
```

When a commit includes anything in `src/posts/`, the hook:

1. Runs `npm run fix-filenames`, which renames posts to `yyyy-mm-dd-title.md` (using `git mv`) and stages the renames.
2. Runs `npm run geocode` if `.env` contains a `LOCATIONIQ_KEY`. Without a key it prints a warning and skips this step.
3. Runs `npm run markers` and stages `assets/geocoded_locations.json` and `assets/markers.json`.

Commits that don't touch posts skip the hook entirely. To preview filename changes without applying them: `node tools/fix-post-filenames.js --dry-run`.

## Deployment

The site is built and deployed by a GitHub Actions workflow (`.github/workflows/eleventy.yml`) that runs `npm ci` and `npm run 11ty:build`, then publishes `_site/`. In the repository settings, Pages must use **GitHub Actions** as its source. The custom domain comes from the `CNAME` file and the Pages settings.

The main branch should be ready to deploy at all times, so push directly to main only for tiny changes like new reviews. For new features, branch from main, develop locally with `npm run 11ty:serve`, push the branch, and merge via a pull request.

## Other services

- OpenStreetMap, Leaflet and MapTiler provide the map tiles and display.
- MailerLite stores subscribers and sends emails to them.
- Pipedream receives the subscribe form's webhook and adds subscribers to MailerLite, triggers emails for new posts, and handles the other automations.
- `/latest/` redirects to the newest review, and is the link used in subscriber emails. It updates on each build.
- `sw.js` is a retirement script for the old Jekyll site's service worker. It clears the old caches in returning visitors' browsers. It can be removed after a few months.

## To do

Migration:

- Decide how to keep old Jekyll URLs (`/reviews/yyyy/mm/dd/slug/`) working now that posts live at `/posts/...`
- Check whether the old site served a feed, sitemap or `robots.txt`, and port them
- Add `dishes` to the posts the migration script skipped, and fix double-encoded characters (`grep -rn "Ã" src/posts`)
- Replace the repeated `src/posts/**/*.md` glob with a `posts.json` directory data file and the built-in `reviews` tag
- Rotate the old LocationIQ key (it is in git history) and restrict the MapTiler key to this domain

Content:

- Add the rest of the old reviews, and separate out repeat reviews into their own files
- Retrieve other missing reviews from the old website (bad pizza in Exmouth is missing)
- Find places reviewed multiple times in Wellington before the switch to the new website and check they are all here
- Change Manawatu to Manawatu-Whanganui across the posts, and take out the macron
- Decide what to do about Palmerston North and fix the city, region and suburb listings
- Look through all the suburbs and fix the wrong ones
- Fix the Mess Tent location in Waiouru

Features (low priority):

- Categories page for filtering by arbitrary category labels
- Stats on ratings, and ratings by region
- Make the tools read suburb, city and region from the address
- A make-new-post script, probably just a shell script

Links to be added:

- Hyderabadi House
- Ohtel Pantry
- Tandoori Dhaba