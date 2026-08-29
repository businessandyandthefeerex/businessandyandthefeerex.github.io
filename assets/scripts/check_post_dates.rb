#!/usr/bin/env ruby
require 'yaml'
require 'date'

files = Dir["_posts/*.md"].sort
missing = []
invalid = []

files.each do |f|
  raw = File.binread(f)
  clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b)
  if clean =~ /\A---\n(.*?)\n---\s*/m
    fm = $1
    # try to parse YAML safely
    begin
      data = YAML.safe_load(fm, permitted_classes: [Date, Time], aliases: true) || {}
    rescue
      data = {}
    end
    date_val = data['date'] || data[:date]
    date_str = date_val.to_s.strip
    if date_str == ''
      missing << f
    else
      begin
        Date.parse(date_str.to_s)
      rescue
        invalid << [f, date_str]
      end
    end
  else
    missing << f
  end
end

puts "TOTAL=#{files.length} MISSING=#{missing.length} INVALID=#{invalid.length}"
if missing.any?
  puts "\nFiles missing/empty date (first 100):"
  puts missing.first(100)
end
if invalid.any?
  puts "\nFiles with invalid date values (first 100):"
  invalid.first(100).each{|f,d| puts "#{f}  --  #{d}"}
end

puts "\nTo auto-fix missing dates by extracting from filenames (YYYY-MM-DD), run:"
puts "  ruby assets/scripts/fix_dates_from_filename.rb --apply"
