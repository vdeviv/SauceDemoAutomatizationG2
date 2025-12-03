
After do 
    Capybara.reset_sessions!
end

Before '@maximize' do
  page.driver.browser.manage.window.maximize
end

at_exit do
  Capybara.current_session.driver.quit
end

