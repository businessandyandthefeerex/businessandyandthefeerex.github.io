# run after jekyll resets the site state, which is after the initial setup but before reading files or generating output
Jekyll::Hooks.register :site, :after_reset do |site|
    puts "Running pre-build tasks..."
  
    # call generator scripts
    system("ruby #{File.join(Dir.pwd, 'assets', 'scripts', 'generate_region_pages.rb')}")
    system("ruby #{File.join(Dir.pwd, 'assets', 'scripts', 'generate_review_date_hierarchy.rb')}")
    system("ruby #{File.join(Dir.pwd, 'assets', 'scripts', 'generate_collections.rb')}")
    # system("ruby #{File.join(Dir.pwd, 'assets', 'scripts', 'generate_map_export.rb')}") # this has been moved to .git\hooks\pre-commit so that the file is alwayws up to date
  
    puts "Pre-build tasks completed."
  end
  