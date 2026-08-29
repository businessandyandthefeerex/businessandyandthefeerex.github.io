#!/usr/bin/env ruby
require 'yaml'
require 'date'

files = Dir["_posts/*.md"].sort
fixed = []
files.each do |f|
  raw = File.binread(f)
  clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b)
  lines = clean.lines
  next unless lines[0]&.strip == '---'
  # find end of first front-matter block
  idx = nil
  (1...lines.length).each do |i|
    if lines[i].strip == '---'
      idx = i
      break
    end
  end
  next unless idx
  # if the next non-empty line after the closing '---' is another '---', treat as duplicate
  next_line = nil
  j = idx + 1
  while j < lines.length && lines[j].strip == ''
    j += 1
  end
  next_line = lines[j]&.strip
  if next_line == '---'
    STDERR.puts "DEBUG: #{f} idx=#{idx} j=#{j} next_line=#{next_line.inspect}"
    # find end of second block
    k = j + 1
    while k < lines.length && lines[k].strip != '---'
      k += 1
    end
    next unless k < lines.length
    second_block = lines[(j+1)...k].join
    begin
      data = YAML.safe_load(second_block, permitted_classes: [Date, Time], aliases: true) || {}
    rescue => e
      STDERR.puts "YAML parse failed for second block of #{f}: #{e.message}"
      next
    end
    STDERR.puts "PARSED_KEYS=#{data.keys.inspect}"
    if (data['category'] && data['category'].to_s.strip != '') || (data['title'] && data['title'].to_s.strip != '')
      # remove the leading block (lines 0..idx)
      rest = lines[(idx+1)..-1].join
      begin
        File.binwrite(f, rest)
        fixed << f
        STDERR.puts "FIXED: #{f}"
      rescue => e
        STDERR.puts "ERROR writing #{f}: #{e.message}"
      end
    else
      STDERR.puts "SKIP (second block not valid): #{f}"
    end
  end
end

puts "FIXED=#{fixed.length}"
fixed.each{|p| puts p}
