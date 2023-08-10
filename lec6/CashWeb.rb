require 'rack'
require 'erb'

class CashMachine
  BALANCE_FILE = 'balance.txt'
  START_BALANCE = 100

  def initialize
    @balance = read_balance
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

  def deposit(amount)
    if amount > 0
      @balance += amount
      "Новый баланс: #{@balance}"
    else
      "Сумма депозита должна быть больше нуля."
    end
  end

  def withdraw(amount)
    if amount > 0 && amount <= @balance
      @balance -= amount
      "Новый баланс: #{@balance}"
    else
      "Сумма должна быть больше нуля и не превышать текущий баланс."
    end
  end

  def show_balance
    "Текущий баланс: #{@balance}"
  end
end

app = Rack::Builder.new do
  cash_machine = CashMachine.new

  map '/process' do
    run ->(env) do
      request = Rack::Request.new(env)
      command = request.params['command']
      amount = request.params['amount'].to_i

      if command == 'deposit'
        response = cash_machine.deposit(amount)
      elsif command == 'withdraw'
        response = cash_machine.withdraw(amount)
      elsif command == 'balance'
        response = cash_machine.show_balance
      else
        response = 'Неверная команда.'
      end

      template_path = File.join(__dir__, 'index.html')
      template = ERB.new(File.read(template_path))
      @response = response
      template_result = template.result(binding)

      [200, {'Content-Type' => 'text/html'}, [template_result]]
    end
  end
end

Rack::Handler::WEBrick.run app, Port: 8080