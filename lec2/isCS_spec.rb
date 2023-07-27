require_relative 'isCS'
require 'rspec'

RSpec.describe 'Check and is_cs' do
  describe '#check' do
    it 'returns true when a word ends with "cs"' do
      expect(check("RubyCS")).to be true
      expect(check("JavaScriptCS")).to be true
    end

    it 'returns false when a word does not end with "cs"' do
      expect(check("Ruby")).to be false
      expect(check("JavaScript")).to be false
    end
  end

  describe '#is_cs' do
    it 'prints 2 raised to the power of word length when the word ends with "cs"' do
      expect { is_cs("RubyCS") }.to output("64\n").to_stdout
      expect { is_cs("JavaScriptCS") }.to output("4096\n").to_stdout
    end

    it 'prints the reverse of the word when the word does not end with "cs"' do
      expect { is_cs("Ruby") }.to output("ybuR\n").to_stdout
      expect { is_cs("JavaScript") }.to output("tpircSavaJ\n").to_stdout
    end
  end
end