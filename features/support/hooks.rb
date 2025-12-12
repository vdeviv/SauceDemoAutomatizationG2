#require_relative '../pages/login_page'
#require_relative '../pages/cart_page'
#require_relative '../pages/checkout_page'
#require_relative '../pages/nav_menu_page'
#require_relative '../pages/product_page'
#require_relative '../pages/filter_page'
#require_relative '../pages/footer_page'

Before do |scenario|
  @login_page = LoginPage.new
  @cart_page = CartPage.new
  @checkout_page = CheckoutPage.new
  @footer_page = FooterPage.new
  @nav_menu_page = NavMenuPage.new 
  @product_page = ProductPage.new
  @filter_page = FilterPage.new

  
end

After do 
    Capybara.reset_sessions!
end

Before '@maximize' do
  page.driver.browser.manage.window.maximize
end

at_exit do
  Capybara.current_session.driver.quit
end

