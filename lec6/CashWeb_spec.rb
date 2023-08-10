require 'rack/test'
require_relative 'CashWeb' # Укажите путь к вашему файлу с классом CashMachine
require 'httparty'

describe 'CashMachineApp' do
  include Rack::Test::Methods

  let(:app) do
    Rack::Builder.parse_file(File.expand_path('my_app.ru', __FILE__)).first
  end

  it 'deposits money and shows updated balance' do
    puts 1
    response = HTTParty.get('http://localhost:8080/deposit?value=50')
    puts 2
    expect(response.code).to eq(200)
    puts 3
    expect(response.body).to include('Новый баланс: 150')
    puts 4
  end

  it 'withdraws money and shows updated balance' do
    response = HTTParty.get('http://localhost:8080/withdraw?value=30')
    expect(response.code).to eq(200)
    expect(response.body).to include('Новый баланс: 70')
  end

  it 'shows current balance' do
    response = HTTParty.get('http://localhost:8080/balance')
    expect(response.code).to eq(200)
    expect(response.body).to include('Текущий баланс: 100')
  end
end
