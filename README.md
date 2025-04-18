Add new reviews to the _posts folder in the root of this repository.
Name them with a date at the start in yyyy-mm-dd format for clarity and to avoid duplicates.
It's important to get the front matter right, that's the stuff between the two lines of --- at the start of the file.
If in doubt, just copy a file and then overwrite what's there with the new values for the new post.

Posts are organised by date by default, but they have a secondary organisation, by country/region/suburb/rating.
This ensures that posts are automatically put into the right lists that filter through to the Browse by Region pages.
You don't need to manually shuffle these pages each time you make a new post, it's all automatic as long as you put the country, region, suburb, and rating in the front matter of each post.
If there is a new region or country you will need to run the generate_region_pages ruby script locally to make the folders and pages before pushing to the remote repo.