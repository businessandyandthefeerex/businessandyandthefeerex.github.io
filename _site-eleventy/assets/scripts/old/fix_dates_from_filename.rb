#!/usr/bin/env ruby
require 'yaml'
require 'date'

apply = ARGV.include?("--apply")
fixed = []

Dir["_posts/*.md"].sort.each do |f|
  raw = File.binread(f)
  clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b)
  if clean =~ /\A---\n(.*?)\n---\s*/m
    fm = $1
    rest = clean.sub(/\A---\n.*?\n---\s*/m, '')
    begin
      data = YAML.safe_load(fm, permitted_classes: [Date, Time], aliases: true) || {}
    rescue
      data = {}
    end
    date_val = data['date'] || data[:date]
    date_str = date_val.to_s.strip
    if date_str == ''
      # try to infer from filename
      if f =~ /^(\d{4}-\d{2}-\d{2})/ 
        inferred = $1
        if apply
          # insert date into the first front-matter block
          new_fm = fm.lines.map do |line|
            if line =~ /^date:\s*$/i
              "date: #{inferred}\n"
            else
              line
            end
          end.join
          # if there was no explicit 'date:' line, add it at end
          unless fm.lines.any?{|l| l =~ /^date:\s*/i}
            new_fm = new_fm + "date: #{inferred}\n"
          end
          new_content = "---\n" + new_fm + "---\n\n" + rest
          File.binwrite(f, new_content)
          fixed << [f, inferred]
        else
          puts "WILL FIX: #{f}  -> #{inferred} (run with --apply to apply)"
        end
      else
        puts "NO FILENAME DATE: #{f}"
      end
    end
  else
    puts "NO FRONT MATTER: #{f}"
  end
end

if apply
  puts "FIXED=#{fixed.length}"
  fixed.each{|f,d| puts "#{f} => #{d}"}
end
