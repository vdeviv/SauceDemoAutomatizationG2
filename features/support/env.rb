begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'

#PTravel Settings
ENV['USER']="megapro"
ENV['PSW']="IHateQA"

Capybara.default_driver = :selenium

# Set the host the Capybara tests should be run against
Capybara.app_host = ENV["CAPYBARA_HOST"]

# Set the time (in seconds) Capybara should wait for elements to appear on the page
Capybara.default_max_wait_time = 15
Capybara.default_driver = :selenium
Capybara.app_host = "https://www.saucedemo.com"

require 'selenium-webdriver'

class CapybaraDriverRegistrar
  # register a Selenium driver for the given browser to run on the localhost
  def self.register_selenium_driver(browser)
    Capybara.register_driver :selenium do |app|
      if browser == :chrome
        options = Selenium::WebDriver::Chrome::Options.new
        options.binary = "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe"
        options.add_argument('--disable-save-password-bubble')
        options.add_argument('--disable-notifications')
        options.add_argument('--disable-infobars')
        # Desactivar el gestor de contraseñas y alertas de seguridad de contraseñas
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
# Register various Selenium drivers
#CapybaraDriverRegistrar.register_selenium_driver(:internet_explorer)
#CapybaraDriverRegistrar.register_selenium_driver(:firefox)
CapybaraDriverRegistrar.register_selenium_driver(:chrome)
Capybara.run_server = false
#World(Capybara)

