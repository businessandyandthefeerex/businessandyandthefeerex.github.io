#!/usr/bin/env ruby
require 'yaml'
require 'date'

files = Dir["_posts/*.md"].sort
fixed = []
files.each do |f|
  raw = File.binread(f)
  clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b)
  next unless clean.start_with?("---\n")
  # find end of first block
  first_end = clean.index("\n---", 3)
  next unless first_end
  # find start of second block (after the closing --- and optional whitespace/newlines)
  rest = clean[(first_end+4)..-1]
  rest_strip = rest.lstrip
  next unless rest_strip.start_with?("---\n")

  first_block = clean[4...first_end+1] # between initial ---\n and \n---
  # determine if first block has any non-empty values (key: value)
  has_value = first_block.lines.any? do |ln|
    ln =~ /^\s*[^:\s]+:\s*\S+/ # key: non-empty value
  end
  next if has_value

  # keep content starting at the second block
  second_start = first_end + 4 + (rest.length - rest_strip.length)
  new_content = clean[second_start..-1]
  File.binwrite(f, new_content)
  fixed << f
end

puts "FIXED=#{fixed.length}"
fixed.each{|p| puts p}
