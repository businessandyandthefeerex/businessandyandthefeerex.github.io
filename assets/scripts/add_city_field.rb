#!/usr/bin/env ruby
require 'yaml'

Dir.chdir(File.expand_path('../../..', __FILE__)) do
  files = Dir['_posts/*.md'].sort
  changed = []
  files.each do |path|
    raw = File.binread(path).force_encoding('ASCII-8BIT')
    clean = raw.sub(/\A\xEF\xBB\xBF/n, ''.b).gsub(/\r\n?/, "\n".b)
    text = clean.force_encoding('UTF-8')
    next unless text =~ /\A---\n(.*?)\n---\n/m
    fm = $1
    rest = $'

    region = (fm[/^region:\s*(.*)$/i, 1] || '').to_s.strip
    suburb = (fm[/^suburb:\s*(.*)$/i, 1] || '').to_s.strip

    city_value = if region.to_s.strip.downcase == 'wellington'
                   'Wellington'
                 else
                   suburb.to_s
                 end

    # ensure city_value is a sensible string
    city_value = city_value.to_s

    if fm =~ /^city:/i
      fm2 = fm.sub(/^city:.*$/i, "city: #{city_value}")
    else
      if fm =~ /^suburb:.*$/i
        fm2 = fm.sub(/(^suburb:.*$)/i, "\\1\ncity: #{city_value}")
      elsif fm =~ /^region:.*$/i
        fm2 = fm.sub(/(^region:.*$)/i, "\\1\ncity: #{city_value}")
      else
        fm2 = fm + "\ncity: #{city_value}"
      end
    end

    new_text = "---\n#{fm2}\n---\n" + rest
    if new_text != text
      File.binwrite(path, new_text)
      changed << path
    end
  end
  puts "UPDATED=#{changed.length}"
  puts changed.join("\n") unless changed.empty?
end
