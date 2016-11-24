require 'digest'

LOOKUP_RANGE = 15000000

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
  steps = steps.to_i + 1
  (1..LOOKUP_RANGE).each do |num|
    steps = steps.to_i + 1
    if Digest::MD5.hexdigest(num.to_s) == target
      steps = steps.to_i + 1
      end_time = Time.now
      puts "Plaintext for #{target}: #{num}"
      puts "Time: #{end_time - start_time}"
      puts "Steps: #{steps}"
      steps = 0
      break
    end
  end
end
