require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber' 
begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end

ENV['USER']="megapro"
ENV['PSW']="IHateQA"

# CRÍTICO: Añadir la carpeta 'pages' al load path global
$LOAD_PATH << File.expand_path('../../pages', __FILE__)

# Extiende el contexto de Cucumber para incluir los métodos de Capybara (CRÍTICO)
World(Capybara::DSL)
World(RSpec::Matchers)

require 'selenium-webdriver'

class CapybaraDriverRegistrar
  def self.register_selenium_driver(browser)
    Capybara.register_driver :selenium do |app|
      if browser == :chrome
        options = Selenium::WebDriver::Chrome::Options.new
        options.binary = "C:/Program Files/Google/Chrome/Application/chrome.exe"
        
        options.add_argument('--disable-save-password-bubble')
        options.add_argument('--disable-notifications')
        options.add_argument('--disable-infobars')
        options.add_preference('credentials_enable_service', false)
        options.add_preference('profile.password_manager_enabled', false)
        options.add_preference('profile.password_manager_leak_detection', false)
        
        Capybara::Selenium::Driver.new(app, :browser => browser, :options => options)
      else
        Capybara::Selenium::Driver.new(app, :browser => browser)
      end
    end
  end
end
CapybaraDriverRegistrar.register_selenium_driver(:chrome)

Capybara.default_driver = :selenium 
Capybara.app_host = "https://www.saucedemo.com" # URL base
Capybara.default_max_wait_time = 10 
Capybara.run_server = false