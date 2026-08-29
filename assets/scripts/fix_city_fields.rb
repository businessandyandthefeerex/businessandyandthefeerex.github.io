#!/usr/bin/env ruby
Dir.chdir(File.expand_path('../../..', __FILE__)) do
  files = Dir['_posts/*.md'].sort
  changed = []
  files.each do |path|
    raw = File.binread(path).force_encoding('ASCII-8BIT')
    clean = raw.sub(/\A\xEF\xBB\xBF/n, ''.b).gsub(/\r\n?/, "\n".b)
    text = clean.force_encoding('UTF-8')

    if text =~ /\A---\n(.*?)\n---\n/m
      fm = $1
      rest = $'

      lines = fm.lines.map(&:chomp)
      # remove all existing city lines (case-insensitive)
      lines_no_city = lines.reject { |ln| ln =~ /^city:\s*/i }

      # extract region and suburb values from original fm
      region = fm[/^region:\s*(.*)$/i, 1] || ''
      region = region.strip
      suburb = fm[/^suburb:\s*(.*)$/i, 1] || ''
      suburb = suburb.strip

      city_value = if region.downcase == 'wellington'
                     'Wellington'
                   else
                     suburb
                   end

      # where to insert city: before suburb if present, else after region if present, else at end
      insert_index = nil
      lines_no_city.each_with_index do |ln, i|
        if ln =~ /^suburb:\s*/i
          insert_index = i
          break
        end
      end
      if insert_index.nil?
        lines_no_city.each_with_index do |ln, i|
          if ln =~ /^region:\s*/i
            insert_index = i + 1
            break
          end
        end
      end
      insert_index = lines_no_city.length if insert_index.nil?

      city_line = "city: #{city_value}"
      # if city_value is empty, keep it empty string
      city_line = 'city: ' if city_value.nil? || city_value == ''

      new_lines = lines_no_city.dup
      new_lines.insert(insert_index, city_line)

      new_fm = new_lines.join("\n")
      new_text = "---\n#{new_fm}\n---\n" + rest
      if new_text != text
        File.binwrite(path, new_text)
        changed << path
      end
    else
      # no front matter: create basic front matter with city empty
      fm2 = "category: \nlayout: \ntitle: \ndate: \nrating: \nmeal: \ncountry: \nregion: \ncity: \nsuburb: \naddress: \n"
      new_text = "---\n#{fm2}---\n" + text
      File.binwrite(path, new_text)
      changed << path
    end
  end

  puts "FIXED=#{changed.length}"
  puts changed.join("\n") unless changed.empty?
end
