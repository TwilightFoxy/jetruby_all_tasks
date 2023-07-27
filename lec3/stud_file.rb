require_relative 'methods'
require 'set'

file_helper = FileHelper.new('lec3/students.txt')
results_file = File.open('lec3/results.txt', 'w')

ages = Set.new

File.open(file_helper.filename, 'r') do |file|
  file.each_line do |line|
    student_age = line.split[2].to_i
    ages.add(student_age)
  end
end

loop do

  if ages.empty?
    puts "Все студенты обработаны. Программа завершается."
    break
  end

  puts "Список возрастов студентов: #{ages.join(', ')}"

  puts "Введите возраст студента (для выхода введите -1):"
  age = gets.chomp.to_i
  break if age == -1

  if ages.include?(age)
    students = []
    File.open(file_helper.filename, 'r') do |file|
      file.each_line do |line|
        student_age = line.split[2].to_i
        if student_age == age
          students << line.chomp
        end
      end
    end

    students.each do |student|
      results_file.puts(student)
    end

    ages.delete(age)
  else
    puts "Студентов с возрастом #{age} нет в файле"
  end
end

results_file.close

puts "\nСодержимое файла results.txt:"
File.open('lec3/results.txt', 'r') do |file|
  file.each_line { |line| puts line }
end
