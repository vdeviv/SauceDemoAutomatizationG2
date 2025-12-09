class LoginPage
  include Capybara::DSL

  USERNAME_FIELD = '#user-name'
  PASSWORD_FIELD = '#password'
  LOGIN_BUTTON = '#login-button'
  ERROR_MESSAGE_CONTAINER = '.error-message-container.error'
  

  def visit_login_page
    visit '/'
    wait_for_login_page
  end
  
  def login_with(username, password)
    fill_in USERNAME_FIELD, with: username
    fill_in PASSWORD_FIELD, with: password
    click_button 'Login' # 
  end

  def click_login_button
    click_button LOGIN_BUTTON
  end
  
  
  def error_message_is_visible?(expected_message)
    has_css?(ERROR_MESSAGE_CONTAINER, text: expected_message, wait: 5)
  end

  def is_on_login_page?
    has_selector?(LOGIN_BUTTON, wait: 5) && current_path == 'https://www.saucedemo.com/'
  end

  private 
  
  def wait_for_login_page
    has_css?(LOGIN_BUTTON, wait: 10)
  end

end