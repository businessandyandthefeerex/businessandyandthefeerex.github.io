#!/usr/bin/env ruby
counts = Hash.new(0)
Dir["_posts/*.md"].sort.each do |f|
  raw = File.binread(f)
  clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b)
  if clean =~ /\A---\n(.*?)\n---\s*/m
    fm = $1
    city = fm[/^city:\s*(.*)$/i,1] || ''
    city = city.to_s.strip.gsub(/^"|"$|^'|'$/,'')
    counts[city] += 1
  else
    counts['(no-front-matter)'] += 1
  end
end

counts = counts.sort_by{|k,v| -v}
puts "CITY COUNTS:"
counts.each do |city, cnt|
  puts "%4d  %s" % [cnt, city.empty? ? '(empty)' : city]
end
