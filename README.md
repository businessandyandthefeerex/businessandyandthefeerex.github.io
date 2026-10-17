For businessandyandthefeerex.co.nz, which is served by Github Pages, and built with Jekyll, using the Alembic theme as a base.

## Local development

These instructions are for Ubuntu or Debian. Install Ruby and the native build tools Jekyll's gems may need:

```sh
sudo apt update
sudo apt install ruby-full build-essential zlib1g-dev
```

Configure RubyGems to install gems in your home directory, rather than the system-owned Ruby directories. Add these lines to `~/.zshrc` (use `~/.bashrc` for Bash):

```sh
export GEM_HOME="$(ruby -rrubygems -e 'print Gem.user_dir')"
export GEM_PATH="$GEM_HOME:$(ruby -rrubygems -e 'print Gem.path.join(":")')"
export PATH="$GEM_HOME/bin:$PATH"
```

Load the configuration in the current terminal (`source ~/.zshrc`, or `source ~/.bashrc` for Bash), then install Bundler and the project's dependencies from the repository root:

```sh
gem install bundler --no-document
bundle install
```

Start the local site with:

```sh
bundle exec jekyll serve
```

Open <http://localhost:4000>. Jekyll rebuilds the site as files change. Do not use `sudo` with `gem install` or `bundle install`; the gems are configured to live in your home directory.

### RubyGems network timeouts

If gem installation fails with `Gem::Net::OpenTimeout`, compare IPv4 and IPv6 connectivity:

```sh
curl -4 -I --connect-timeout 10 https://rubygems.org
curl -6 -I --connect-timeout 10 https://rubygems.org
```

If IPv4 works but IPv6 times out, a Linux workaround is to make the system prefer IPv4. Edit `/etc/gai.conf` with `sudoedit /etc/gai.conf` and add:

```text
precedence ::ffff:0:0/96 100
```

This changes address preference system-wide while the line is present. Remove or comment out the line to undo the workaround after installing the gems.

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

The main branch is intended to be ready for deployment at all times, so pushes directly to main really should only be for tiny changes like new pages. The development workflow for new features is intended to be branching from main into a new branch for the development of the feature, developing locally using `bundle exec jekyll serve` (or `bundle exec jekyll build` followed by `python3 -m http.server -d _site` to inspect the generated site on localhost:8000), pushing commits to the remote repository, and then merging back into main via a pull request.

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
