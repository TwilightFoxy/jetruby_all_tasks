require 'rspec'
require_relative 'file_helper'

describe FileHelper do
  let(:filename) { 'example.txt' }
  let(:file_helper) { FileHelper.new(filename) }

  before do
    # Создаем тестовый файл с данными перед каждым тестом
    File.open(filename, 'w') do |file|
      file.puts 'Иван'
      file.puts 'Алексей'
      file.puts 'Мария'
      file.puts 'Екатерина'
      file.puts 'Александра'
    end
  end

  after do
    # Удаляем тестовый файл после каждого теста
    File.delete(filename) if File.exist?(filename)
  end

  describe '#create' do
    it 'adds a new entry to the file' do
      file_helper.create('Новая запись')
      expect(File.read(filename)).to include('Новая запись')
    end
  end

  describe '#update' do
    it 'updates an entry in the file' do
      file_helper.update(3, 'Тестовая запись')
      expect(File.read(filename)).to include('Тестовая запись')
      expect(File.read(filename)).not_to include('Мария')
    end
  end

  describe '#delete' do
    it 'deletes an entry from the file' do
      file_helper.delete(2)
      expect(File.read(filename)).not_to include('Алексей')
    end
  end

  describe '#index' do
    it 'displays all entries from the file' do
      expect { file_helper.index }.to output(/Иван\nАлексей\nМария\nЕкатерина\nАлександра/).to_stdout
    end
  end

  describe '#find' do
    it 'displays an entry with a given index from the file' do
      expect { file_helper.find(3) }.to output("Мария\n").to_stdout
    end
  end

  describe '#where' do
    it 'displays entries containing a given pattern from the file' do
      expect { file_helper.where('и') }.to output(/Иван\nМария\nЕкатерина\nАлександра/).to_stdout
    end
  end
end