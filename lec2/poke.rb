def add_pokemon(poke_array, name, color)
  poke_array << { name: name, color: color }
end

def create_pokemon_array
  poke_array = []
  puts "Сколько покемонов нужно добавить?"
  num_poke = gets.chomp.to_i

  num_poke.times do |i|
    puts "Введите имя покемона #{i + 1}:"
    name = gets.chomp
    puts "Введите цвет покемона #{i + 1}:"
    color = gets.chomp
    add_pokemon(poke_array, name, color)
  end

  poke_array
end

# poke_array = create_pokemon_array
# puts poke_array