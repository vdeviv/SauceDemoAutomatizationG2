
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber' 

begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end

ENV['USER']="megapro"
ENV['PSW']="ITRYLOVEQA"



World(Capybara::DSL)
World(RSpec::Matchers)

require 'selenium-webdriver'

class CapybaraDriverRegistrar
  def self.register_selenium_driver(browser)
    Capybara.register_driver :selenium do |app|
      if browser == :chrome
        options = Selenium::WebDriver::Chrome::Options.new
        options.binary = "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe"
        
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
# Se registra el driver de Chrome
CapybaraDriverRegistrar.register_selenium_driver(:chrome)

# --- Configuración Global de Capybara ---
# Nota: Eliminamos las definiciones duplicadas y usamos los valores estándar.
Capybara.default_driver = :selenium 
Capybara.app_host = "https://www.saucedemo.com" # URL base
# Usamos 10 segundos como estándar, ya que es más rápido que 15.
Capybara.default_max_wait_time = 10 
Capybara.run_server = false