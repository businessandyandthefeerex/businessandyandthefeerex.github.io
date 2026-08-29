#!/usr/bin/env ruby
files = Dir["_posts/*.md"].sort
one_city=0
zero_city=0
multi_city=0
mismatch=[]
files.each do |f|
  raw = File.binread(f)
  clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b).force_encoding('UTF-8')
  if clean =~ /\A---\n(.*?)\n---\n/m
    fm = $1
    lines = fm.lines.map(&:chomp)
    city_lines = lines.select{|ln| ln =~ /^city:\s*/i}
    if city_lines.length == 1
      one_city += 1
    elsif city_lines.length == 0
      zero_city += 1
    else
      multi_city += 1
    end
    region = fm[/^region:\s*(.*)$/i,1] || ''
    region = region.strip
    suburb = fm[/^suburb:\s*(.*)$/i,1] || ''
    suburb = suburb.strip
    city = city_lines.first ? city_lines.first.sub(/^city:\s*/i, '').strip : ''
    expected = region.downcase == 'wellington' ? 'Wellington' : suburb
    city_norm = city.gsub(/^"|"$|^'|'$/,'')
    if city_norm != expected
      mismatch << [f, region, suburb, city, expected]
    end
  else
    zero_city += 1
    mismatch << [f, '(no-fm)', '', '', '(expected)']
  end
end
puts "FILES=#{files.length} ONE_CITY=#{one_city} ZERO_CITY=#{zero_city} MULTI_CITY=#{multi_city} MISMATCH=#{mismatch.length}"
mismatch.first(200).each{|m| puts m.join(' | ')}
