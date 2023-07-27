require_relative 'poke'
require 'rspec'

RSpec.describe 'create_pokemon_array' do
  before do
    allow_any_instance_of(Kernel).to receive(:puts)
    allow_any_instance_of(Kernel).to receive(:gets).and_return("2", "Pikachu", "Yellow", "Charmander", "Orange")
  end

  it 'generates an array of Pokemon based on input' do
    expected_array = [
      { name: "Pikachu", color: "Yellow" },
      { name: "Charmander", color: "Orange" }
    ]

    expect(create_pokemon_array).to eq(expected_array)
  end
end