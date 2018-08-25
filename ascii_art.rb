require_relative 'file_importer'

array_2d = []
(1..100).each do |x|
  array = []
  (1..100).each do |y|
    array << ' '
  end
  array_2d << array
end
# puts array_2d
array_of_lines = FileImporter.split_on_line_from_link('http://interview.plaid.com/plaid-first-round.txt')

array_of_lines.each do |line|
  point = line.tr('[]', '').split(',')
  x = point[0].to_i
  y = point[1].to_i
  ascii = point[2].to_i
  array_2d[y][x] = ascii.chr
end

array_2d.each do |s_array|
  puts s_array.join('')
end
