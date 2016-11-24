require 'digest'
require 'csv'

FILE_RANGE = 10000000
ORIGINAL_FILE = "tables/#{FILE_RANGE}.csv"
FINAL_FILE = "tables/#{FILE_RANGE}-sorted.csv"

start_time = Time.now

puts "Creating all possible combination cipher in range: #{FILE_RANGE}.."
combination_start_time = Time.now
CSV.open(ORIGINAL_FILE, "wb") do |csv|
  csv << ["cipher","plain"]
  (1..FILE_RANGE).each do |num|
    plain = num.to_s
    cipher = Digest::MD5.hexdigest(plain)

    csv << [cipher,plain]
  end
end

combination_end_time = Time.now
puts "All combination cipher generation time: #{combination_end_time - combination_start_time}"

puts "Sorting and shortening the key length.."
sorting_start_time = Time.now

unshortened_hash = {}
CSV.foreach(ORIGINAL_FILE, :headers => true) do |row|
  unshortened_hash[row.fields[0][0..7]] = row.fields[1].to_s
end

sorted_hash = Hash[unshortened_hash.sort_by{ |k, v| k }]

CSV.open(FINAL_FILE, "wb") do |csv|
  csv << ["cipher","plain"]
  sorted_hash.each do |sorted|
    csv << [sorted[0], sorted[1]]
  end
end

sorting_end_time = Time.now
puts "Time for sorting and shortening keys: #{sorting_end_time - sorting_start_time}"

