require_relative 'file_helper'
require 'set'

class StudList
  attr_reader :ages

  def initialize(input, output)
    @file_in = input
    @file_out = output
    @ages = Set.new
  end

  def main
    file_in = FileHelper.new(@file_in)
    file_out = File.open(@file_out, 'w')

    ages = Set.new

    File.open(file_in.filename, 'r') do |file|
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

      age = user_input("Введите возраст студента (для выхода введите -1):")
      break if age == -1

      if ages.include?(age)
        students = []
        File.open(file_in.filename, 'r') do |file|
          file.each_line do |line|
            student_age = line.split[2].to_i
            if student_age == age
              students << line.chomp
            end
          end
        end

        students.each do |student|
          file_out.puts(student)
        end

        ages.delete(age)
      else
        puts "Студентов с возрастом #{age} нет в файле"
      end
    end

    file_out.close

    puts "\nСодержимое файла results.txt:"
    File.open(@file_out, 'r') do |file|
      file.each_line { |line| puts line }
    end
  end

  def run
    main
  end

  private

  def user_input(prompt)
    if ENV['TEST_ENV'] == 'true'
      gets.chomp.to_i
    else
      puts prompt
      STDIN.gets.chomp.to_i
    end
  end
end

# stud_list = StudList.new("lec3/students.txt", "lec3/results.txt")
# stud_list.run
