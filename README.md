For businessandyandthefeerex.co.nz, which is served by Github Pages, and built with Jekyll, using the Alembic theme as a base.

Add new reviews to the _posts folder in the root of this repository.
Name them with a date at the start in yyyy-mm-dd format for clarity, to avoid duplicates, and to make the automatic date folders work.
It's important to get the front matter right for each post, that's the stuff between the two lines of --- at the start of the file.
If in doubt, just copy a file and then overwrite what's there with the new values for the new post.

Posts are organised by date by default, but they have a secondary organisation, by country/region/suburb/rating.
This ensures that posts are automatically put into the right lists that filter through to the Browse by Region pages.
You don't need to manually shuffle these pages each time you make a new post, it's all automatic as long as you put the correct front matter at the start of each post.

If you make a post that is in a new region or country, new country and region directories and index pages aren't added automatically by Jekyll, there are a few generator scripts that do this.
But you don't need to run the generate scripts yourself, the after_reset script in the plugins folder ensures that they are all called when jekyll build runs.
And Githib has a workflow built in that runs a jekyll build command whenever there is a new commit to the main branch, so just push or merge to main, and the site will be rebuilt completely.

The generate_geocoded_locations_json and the generate_leaflet_markers scripts can't be run in github pages natively, so instead, they run locally with a githook on commit, but if you're just building locally then they run as part of the after_reset script. Git hooks are located in the .githooks/ directory. If you're using VSCode you'll need the githooks extension to ensure it runs because windows doesn't really play nice with git, and you'll need to change your local git hooks directory to .githooks too, this can be done from the extension. Note that some variables have been set absolutely in this script, so check this before running.

The main branch is intended to be ready for deployment at all times, so pushes directly to main really should only be for tiny changes like new pages. The development workflow for new features is intended to be branching from main into a new branch for the development of the feature, developing locally using jekyll build and then python -m http.server -d _site to inspect the site on localhost:8000, pushing commits to the remote repository, and then merging back into main via a pull request.

Additional tools used:
 - openstreetmaps & leaflet maps - generate and embed maps from location data, using a theme from maptiler
 - mailerlite - stores subscriber email addresses, formats and sends emails to subscribers
 - pipedream - automation workflows for adding subscribers to mailerlite from the subscribe form, for triggering emails on new posts via rss, and for uploading new map csv files to google drive

To do:
 - add rest of the old reviews, separate out repeat reviews into their own files
 - categories table page for filtering by arbitrary category labels (low priority)
 - stats on ratings and also ratings by regions maybe (low priority)

Links to be added:
 - Hyderabadi House
 - Ohtel Pantry
 - Tandoori Dhaba
