f = "_posts/2025-05-24-soul-shack.md"
raw = File.binread(f)
clean = raw.sub(/\A\xEF\xBB\xBF/n, "".b).gsub(/\r\n?/, "\n".b)
lines = clean.lines
puts "First 30 lines with indices:"
lines.first(30).each_with_index{|l,i| puts "%3d: %p" % [i+1, l]}
idx = nil
(1...lines.length).each do |i|
  if lines[i].strip == '---'
    idx = i
    break
  end
end
puts "idx=#{idx.inspect} next_line=#{lines[idx+1]&.inspect}"
