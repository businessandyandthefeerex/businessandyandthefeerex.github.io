#!/usr/bin/env ruby
files = Dir["_posts/*.md"].sort
matches = []
files.each do |f|
  raw = File.binread(f)
  clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b)
  if clean =~ /\A---\n(.*?)\n---\s*\n---\s*\n/m
    matches << f
  end
end
puts "DOUBLE_FM=#{matches.length}"
matches.each{|m| puts m}
