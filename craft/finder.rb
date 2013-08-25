require 'scanf'

fp_name_idx = File.new("db/_name_index.txt", "r")
opt	= Hash.new
name_idx = Hash.new

fp_name_idx.each_line do |line|
	name, file = line.split(' ')
	
	fp_db = File.new("db/#{file}.txt", "r")
	opt[name] = Array.new
	name_idx[file] = name
	
	depth = file.split("_")

	if depth.count >= 2
		# inherent
		opt[ name_idx["#{depth[0]}_#{depth[1]}"] ].each do |option|
			opt[name].push option
		end
	end

	fp_db.each_line do |option|
		opt[name].push option
	end

	fp_db.close
end

fp_name_idx.close

while true
	printf "input category ==> "
	input = scanf("%s")[0]

	break if input == "exit"

	if opt[input] != nil
		opt[input].each do |option|
			puts option
		end
	else
		puts "not found"
	end
end