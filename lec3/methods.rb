class FileHelper
  def initialize(filename)
    @filename = filename
  end

  def filename
    @filename
  end

  def index
    File.open(@filename, "r") do |file|
      file.each_line { |line| puts line }
    end
  end

  def find(id)
    File.open(@filename, "r") do |file|
      file.each_line.with_index(1) do |line, index|
        puts line if index == id
      end
    end
  end

  def where(pattern)
    File.open(@filename, "r") do |file|
      file.each_line do |line|
        puts line if line.include?(pattern)
      end
    end
  end

  def update(id, text)
    File.open(@filename, "r+") do |file|
      lines = file.readlines
      file.rewind
      file.truncate(0)
      lines.each.with_index(1) do |line, index|
        if index == id
          file.puts text
        else
          file.puts line
        end
      end
    end
  end

  def delete(id)
    File.open(@filename, "r+") do |file|
      lines = file.readlines
      file.rewind
      file.truncate(0)
      lines.each.with_index(1) do |line, index|
        file.puts line unless index == id
      end
    end
  end

  def create(text)
    File.open(@filename, "a+") do |file|
      file.puts text
    end
  end
end


# Просто тестирование методов
# file_helper = FileHelper.new("example.txt")
#
# file_helper.create("Иван")
# file_helper.create("Алексей")
# file_helper.create("Мария")
# file_helper.create("Екатерина")
# file_helper.create("Александра")
#
# puts "Исходное содержимое файла:"
# file_helper.index
# puts ""
#
# file_helper.update(3, "тест")
#
# puts "Измененное содержимое файла:"
# file_helper.index
