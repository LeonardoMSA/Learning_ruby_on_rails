require 'selenium-webdriver'
require 'cgi'

class WhatsappService
  def initialize
    options = Selenium::WebDriver::Firefox::Options.new
    @driver = Selenium::WebDriver.for :firefox, options: options
    @driver.navigate.to "https://web.whatsapp.com"
    puts "Please scan the QR Code with your WhatsApp app."
  end

  def wait_for_login
    wait = Selenium::WebDriver::Wait.new(timeout: 300)
    wait.until { @driver.find_element(css: "div._al_j") }  # Adjusted to a more reliable element for QR code display
    puts "Logged in!"
  end

  def send_test_message(phone, message)
    @driver.navigate.to "https://web.whatsapp.com/send?phone=#{phone}&text=#{CGI.escape(message)}"
    wait = Selenium::WebDriver::Wait.new(timeout: 60)
    input_box = wait.until {
      element = @driver.find_element(css: 'div[contenteditable="true"]')
      element if element.displayed?
    }
    
    sleep(10)  # Ensure WhatsApp loads the input box correctly
    input_box.send_keys(:enter)  # Press Enter to send
    sleep(2)
  end

  #selectable-text copyable-text x15bjb6t x1n2onr6
  

  def quit
    @driver.quit
  end
end

class WhatsappController < ApplicationController
  skip_before_action :verify_authenticity_token

  def start
    @whatsapp_service = WhatsappService.new
    render plain: "Please scan the QR Code now."
  end

  def messageForm
    #Isso está aqui para renderizar o form
  end

  def send_message
    phone = params[:phone]
    message = params[:message]

    @whatsapp_service = WhatsappService.new
    @whatsapp_service.wait_for_login
    @whatsapp_service.send_test_message(phone, message)
    @whatsapp_service.quit

    redirect_to root_path, notice: "Message sent successfully to #{phone}."
  end
end
