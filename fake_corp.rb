# ruby fake_corp.rb [file_path]
require 'csv'


class FakeCorp
	WORKWEEK = 35

	def initialize(input_file)
		@employees = load_file input_file
	end

	def get_overtime_workers out_file = "employees.txt"
		if @employees  
			overtime_workers = []
			@employees.each do |employee|
				overtime_workers << employee[0] if employee[1..-1].map(&:to_i).max > WORKWEEK
			end
			result = overtime_workers.size > 0 ? overtime_workers.sort_by{|e| e.split(" ")[1]}.join("\n") : "No employees found  who worked over-time"
		else
			result = "No employees in the corporation" 
		end
		write_file out_file, result	
	end

	private
		def load_file(file) 
			CSV.read(file) if File.exist?(file)
		end

		def write_file(file, text)
			File.open(file, 'w'){|f| f.write(text) }
		end
end

fake_corp_data = ARGV.size > 0 ? ARGV[0] : 'fake_corp.csv'
puts "Data file :#{fake_corp_data}"

fake_corp = FakeCorp.new fake_corp_data
fake_corp.get_overtime_workers 'employees.txt'

puts "Results file: employees.txt"
