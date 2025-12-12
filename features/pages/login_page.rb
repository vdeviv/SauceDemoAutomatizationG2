class LoginPage
  include Capybara::DSL

  def visit_login_page
    page.driver.browser.manage.window.maximize
    visit '/'
  end
  
  def enter_credentials(username, password)
        fill_in 'user-name', with: username
        fill_in 'password', with: password
  end

  def click_login_button
    click_button('login-button')
  end

  def enter_username(username)
    fill_in 'user-name', with: username
  end

  def enter_password(password)
    fill_in 'password', with: password
  end

  def login_with_credentials(username, password)
    enter_username(username)
    enter_password(password)
    click_login_button
  end
  
  def expected_title_displayed?(title)
    find('#header_container > div.header_secondary_container > span').text == title
  end

  def get_page_title
    find('#header_container > div.header_secondary_container > span').text
  end

  def get_error_message
    find(:css, '#login_button_container > div > form > div.error-message-container.error > h3').text
  end

  def error_message_is_visible?(expected_message)
    get_error_message == expected_message
  end

  def is_on_login_page?
    has_button?('login-button')
  end

end