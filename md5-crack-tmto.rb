require 'digest'
require 'csv'

FILE_RANGE = 10000000
TABLE_FILE = "tables/#{FILE_RANGE}-sorted.csv"

loading_start_time = Time.now
puts "Parsing and loading table to memory.."

temp_hash = {}
CSV.foreach(TABLE_FILE, :headers => true) do |row|
  temp_hash[row.fields[0]] = row.fields[1].to_s
end

loading_end_time = Time.now
puts "Table loaded in: #{loading_end_time - loading_start_time} sec"

target_hashes = []
target_hash = ""

while target_hash != "stop"
  puts "Input target hash: "
  target_hash=gets.strip
  target_hashes.push target_hash if target_hash != "stop"
end

steps = 0

target_hashes.each do |target|
  start_time = Time.now
  chopped_hash = target[0..7]
  temp_hash.each do |hash|
    steps = steps.to_i + 1
    if hash[0] == chopped_hash
      steps = steps.to_i + 1
      if Digest::MD5.hexdigest(hash[1].to_s) == target
        steps = steps.to_i + 1
        end_time = Time.now
        puts "Plaintext for #{target}: #{hash[1]}"
        puts "Time: #{end_time - start_time} sec"
        puts "Steps: #{steps}"
        steps = 0
        break
      end
    end
  end
end

