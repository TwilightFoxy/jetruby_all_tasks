class CashMachine
  BALANCE_FILE = 'lec3/balance.txt'
  START_BALANCE = 100

  def initialize
    @balance = read_balance
    self.run
  end

  def read_balance
    if File.exist?(BALANCE_FILE)
      File.read(BALANCE_FILE).to_i
    else
      START_BALANCE
    end
  end

  def save_balance
    File.write(BALANCE_FILE, @balance.to_s)
  end

  def deposit
    puts "Введите сумму для депозита:"
    amount = gets.chomp.to_i

    if amount > 0
      @balance += amount
      puts "Новый баланс: #{@balance}"
    else
      puts "Сумма депозита должна быть больше нуля."
    end
  end

  def withdraw
    puts "Введите сумму для снятия:"
    amount = gets.chomp.to_i

    if amount > 0 && amount <= @balance
      @balance -= amount
      puts "Новый баланс: #{@balance}"
    else
      puts "Сумма должна быть больше нуля и не превышать текущий баланс."
    end
  end

  def show_balance
    puts "Текущий баланс: #{@balance}"
  end

  def run
    loop do
      puts <<~MENU
      Введите:
        D - для депозита
        W - для снятия
        B - для проверки баланса
        Q - для выхода
      MENU
      action = gets.chomp.downcase

      case action
      when 'd'
        deposit
      when 'w'
        withdraw
      when 'b'
        show_balance
      when 'q'
        save_balance
        puts "Текущий баланс сохранен. Программа завершается."
        break
      else
        puts "Неверная команда. Введите D, W, B или Q."
      end
    end
  end
end

cash_machine = CashMachine.new
# cash_machine.run