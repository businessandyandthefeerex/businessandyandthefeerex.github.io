# run after jekyll resets the site state, which is after the initial setup but before reading files or generating output
Jekyll::Hooks.register :site, :after_reset do |site|
    puts "Running pre-build tasks..."
  
    # call generator scripts
    system("ruby #{File.join(Dir.pwd, 'assets', 'scripts', 'generate_region_pages.rb')}")
    system("ruby #{File.join(Dir.pwd, 'assets', 'scripts', 'generate_review_date_hierarchy.rb')}")
    system("ruby #{File.join(Dir.pwd, 'assets', 'scripts', 'generate_collections.rb')}")
    # these next two scripts have been added to .git\hooks\pre-commit so that they can run before every commit to keep the files up to date
    # ruby scripts can't be run natively in github as part of a jekyll build action, so this way they can still run, but we'll keep these
    # two scripts in the pre-build tasks for local builds too
    system("ruby #{File.join(Dir.pwd, 'assets', 'scripts', 'generate_geocoded_locations_json.rb')}")
    system("ruby #{File.join(Dir.pwd, 'assets', 'scripts', 'generate_leaflet_markers.rb')}")
  
    puts "Pre-build tasks completed."
  end
  