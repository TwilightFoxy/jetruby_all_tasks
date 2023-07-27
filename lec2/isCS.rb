def check(word)
  word.downcase.end_with?("cs")
end

def is_cs(word)
  if check(word)
    puts 2 ** word.length
  else
    puts word.reverse
  end
end