#!/usr/bin/env ruby
require 'yaml'
require 'date'

files = Dir["_posts/*.md"].sort
total = files.length
no_fm = []
parse_err = []
missing_keys = []
required = %w[category layout title date rating meal country region city suburb address]

files.each do |f|
  raw = File.binread(f)
  clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b).force_encoding('UTF-8')
  unless clean =~ /\A---\n(.*?)\n---\n/m
    no_fm << f
    next
  end
  fm = $1
  begin
    data = YAML.safe_load(fm, permitted_classes: [Date, Time], aliases: true) || {}
  rescue => e
    parse_err << [f, e.message]
    next
  end
  keys = (data.keys || []).map{|k| k.to_s.downcase}
  miss = required.reject{|k| keys.include?(k.downcase)}
  unless miss.empty?
    missing_keys << [f, miss]
  end
end

puts "TOTAL=#{total} NO_FRONT_MATTER=#{no_fm.length} PARSE_ERRORS=#{parse_err.length} MISSING_KEYS=#{missing_keys.length}"
if no_fm.any?
  puts "\nFiles missing front matter (first 50):"
  puts no_fm.first(50)
end
if parse_err.any?
  puts "\nFiles with YAML parse errors (first 50):"
  parse_err.first(50).each{|f,e| puts "#{f}  --  #{e}"}
end
if missing_keys.any?
  puts "\nFiles missing required keys (first 50):"
  missing_keys.first(50).each{|f,miss| puts "#{f}  --  missing: #{miss.join(', ')}"}
end
