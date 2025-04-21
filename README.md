Add new reviews to the _posts folder in the root of this repository.
Name them with a date at the start in yyyy-mm-dd format for clarity and to avoid duplicates.
It's important to get the front matter right, that's the stuff between the two lines of --- at the start of the file.
If in doubt, just copy a file and then overwrite what's there with the new values for the new post.

Posts are organised by date by default, but they have a secondary organisation, by country/region/suburb/rating.
This ensures that posts are automatically put into the right lists that filter through to the Browse by Region pages.
You don't need to manually shuffle these pages each time you make a new post, it's all automatic as long as you put the country, region, suburb, and rating in the front matter of each post.
If you make a post that is in a new region or country, new countries and regions aren't added automatically.
You will need to run the generate_region_pages ruby script locally to make the folders and pages before pushing to the remote repo.
Or you can create the folders and pages manually if you prefer, but to save some time and a headache, run the script.

The generate_map_export ruby script takes the address, title, and rating from each blog post and turns them all into a single list that can be imported as a layer into google maps. So run this script after creating a new post, then upload the csv into the google map that the map page points to.

to do  
make it so that country/region collections can also be navigated in a hierarchical manner  
categories/collections page  
map automation if possible  
test if multiple categories can dynamically create folders for blog posts  
categories page for filtering by arbitrary category labels
metadata on each blog post/categories
print location, rating, and meal + date on each blog page
add rest of reviews