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

To start a new review, double-click `assets/scripts/new-review.sh`. It creates a draft with the required front matter in `_posts`, using a filename such as `yyyy-mm-dd-new-review.md`, and opens it in your default text editor. Rename the file when you have the restaurant name and fill in the blank front matter fields before saving.

Once the review is complete, double-click `assets/scripts/publish-review.sh`. It uses the newest review draft by default, adds the review to Git, creates a commit, and pushes it to the current branch. The repository's pre-commit hook handles review filename and map marker generation. You can also run the script with a review path when publishing a specific draft.

Add new reviews to the `_posts` folder in the root of this repository. Name them with a date at the start in yyyy-mm-dd format for clarity, to avoid duplicates, and to make the automatic date folders work. It's important to get the front matter right for each post, that's the stuff between the two lines of `---` at the start of the file. If in doubt, copy a file and overwrite its contents with the values for the new post.

`src/search-index.11ty.js` generates `/assets/search.json` from every review (title, body, dishes, location, rating, meal, date). `assets/scripts/search.js` fetches it and filters in the browser.

## Pre-commit hook

The hook is `.githooks/pre-commit`. Enable it once per clone from the repository root:

```sh
git config core.hooksPath .githooks
```

This is a repository-local setting; the hook then runs automatically before each `git commit`. On Linux and macOS, no VS Code extension is needed. The current hook runs the post-filename fixer and Leaflet marker generator; its geocoding step is commented out because it is currently broken. Some scripts contain absolute paths, so review those assumptions before using the generators on another machine.

The main branch is intended to be ready for deployment at all times, so pushes directly to main really should only be for tiny changes like new pages. The development workflow for new features is intended to be branching from main into a new branch for the development of the feature, developing locally using `bundle exec jekyll serve` (or `bundle exec jekyll build` followed by `python3 -m http.server -d _site` to inspect the generated site on localhost:8000), pushing commits to the remote repository, and then merging back into main via a pull request.

Additional tools used:
 - openstreetmaps & leaflet maps - generate and embed maps from location data, using a theme from maptiler
 - mailerlite - stores subscriber email addresses, formats and sends emails to subscribers
 - pipedream - automation workflows for adding subscribers to mailerlite from the subscribe form, for triggering emails on new posts via rss, and for uploading new map csv files to google drive

To do:
 - add rest of the old reviews, separate out repeat reviews into their own files
 - categories table page for filtering by arbitrary category labels (low priority)
 - stats on ratings and also ratings by regions maybe (low priority)
 - fix the regions page
 - change to manawatu-whanganui, take out the macron
 - change all the manawatu region posts to manawatu-whanganui
 - decide what to do about palmerston north & fix the city/region/suburb listings
 - look through all the suburbs and fix the ones that are wrong
 - find places reviewed multiple times in wellington before the switch to the new website and check that they are all here
 - retrieve other missing reviews from the old website somehow, perhaps scrape the index and then check against the file list, bad pizza in exmouth is missing
 - fix generation scripts to make them case insensitive (ie: Dinner = dinner)
 - migration to 11ty
 - make generation scripts read suburb, city, region from address
 - make generation scripts work with a single pass instead of looping through every post for every script
 - make fix post filename script work as part of the after_reset script in the _plugin folder
 - make the generate geocoded locaitons script work from the cloud, save the api key as a github secret, also make it only work for missing locations, and then make the generate leaflet markers script also work incrementally and work in github's build action
 - work out how to do links and add the link to the chow review

Links to be added:

- Hyderabadi House
- Ohtel Pantry
- Tandoori Dhaba