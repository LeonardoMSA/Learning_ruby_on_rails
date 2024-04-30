# app/services/whatsapp_service.rb
require 'selenium-webdriver'

class WhatsappService
  def initialize
    @driver = Selenium::WebDriver.for :chrome
    @driver.navigate.to "https://web.whatsapp.com"
    puts "Please scan the QR Code with your WhatsApp app."
  end

  def wait_for_login
    # Espera até que o usuário faça login escaneando o QR Code
    wait = Selenium::WebDriver::Wait.new(timeout: 300) # Ajuste o timeout conforme necessário
    wait.until { @driver.find_element(css: "._3auIg") }
    puts "Logged in!"
  end

  def send_test_message(phone)
    # Substitua pelo número em formato internacional, exemplo: '5511900001234'
    @driver.navigate.to "https://web.whatsapp.com/send?phone=#{phone}"
    wait = Selenium::WebDriver::Wait.new(timeout: 60)
    input_box = wait.until {
      element = @driver.find_element(class: '_13mgZ')
      element if element.displayed?
    }
    input_box.send_keys("Hello, this is a test message from Ruby on Rails app using Selenium WebDriver.")
    input_box.send_keys(:enter) # Pressiona Enter para enviar
  end

  def quit
    @driver.quit
  end
end
