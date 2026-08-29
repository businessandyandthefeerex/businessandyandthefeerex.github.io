#!/usr/bin/env ruby
require 'yaml'

def normalize(s)
  s.to_s.strip
end

def levenshtein(a,b)
  a = a.to_s
  b = b.to_s
  return b.length if a.empty?
  return a.length if b.empty?
  v0 = (0..b.length).to_a
  v1 = Array.new(b.length+1)
  a.chars.each_with_index do |ac,i|
    v1[0] = i+1
    b.chars.each_with_index do |bc,j|
      cost = ac==bc ? 0 : 1
      v1[j+1] = [v1[j] + 1, v0[j+1] + 1, v0[j] + cost].min
    end
    v0 = v1.dup
  end
  v1[b.length]
end

counts = Hash.new(0)
Dir["_posts/*.md"].sort.each do |f|
  raw = File.binread(f)
  clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b)
  if clean =~ /\A---\n(.*?)\n---/m
    fm = $1
    begin
      data = YAML.safe_load(fm) || {}
    rescue
      data = {}
    end
    city = normalize(data['city'])
    counts[city] += 1
  end
end

items = counts.sort_by{|k,v| -v}
puts "TOTAL_UNIQUE_CITIES=#{items.length}"
items.each{|k,v| puts "%4d  %s" % [v, k.inspect]}

puts "\nPOTENTIAL_MISSPELLINGS (distance <= 2):"
names = items.map{|k,_| k}
names.each_with_index do |n,i|
  next if n.to_s.strip==''
  names[(i+1)..-1].each do |m|
    d = levenshtein(n.downcase, m.downcase)
    if d <= 2
      puts "#{n.inspect} <-> #{m.inspect}  (#{d})"
    end
  end
end
