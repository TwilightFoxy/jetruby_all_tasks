#1 Метод greeting
def greeting
  puts "Введите имя:"
  name = gets.chomp
  puts "Введите фамилию:"
  surname = gets.chomp
  puts "Введите возраст:"
  age = gets.chomp.to_i

  if age < 18
    puts "Привет, #{name} #{surname}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано"
  else
    puts "Привет, #{name} #{surname}. Самое время заняться делом!"
  end
end

greeting

#2 Метод foobar
def foobar(num1, num2)
  if num1 == 20 || num2 == 20
    return num2
  else
    return num1 + num2
  end
end

puts foobar(10, 20)
puts foobar(5, 5)
puts foobar(20, 30)