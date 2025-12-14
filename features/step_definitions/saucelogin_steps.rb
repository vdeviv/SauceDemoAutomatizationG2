
Given('estoy en la página de inicio de sesión') do
  @login_page.visit_login_page
end

When('ingreso el nombre de usuario {string}') do |username|
  @login_page.enter_username(username)
end

When('ingreso la contraseña {string}') do |password|
  @login_page.enter_password(password)
end

When('hago click en el botón {string}') do |button_name|
  case button_name
  when 'Login'
    @login_page.click_login_button
  when 'Checkout', 'Continue Shopping'
    @cart_page.click_navigation_button(button_name)
  when 'Continue'
    @checkout_page.click_continue
  when 'Finish'
    @checkout_page.click_finish
  when 'Back Home'
    @checkout_page.click_back_home
  when 'Cancel'
     click_button 'cancel'
  else
    click_button button_name
  end
end

Then('soy redirigido a la página de productos') do
  expect(@login_page.expected_title_displayed?('Products')).to be true
end

When('hago click en el botón de menú') do
  @nav_menu_page.open_menu
end

When('hago click en el enlace {string}') do |link_text|
  @nav_menu_page.click_menu_item(link_text)
end

Then('soy redirigido a la página de inicio de sesión') do
  expect(@login_page.is_on_login_page?).to be true
end

Then('veo el mensaje de error de login {string}') do |error_message|
  expect(@login_page.error_message_is_visible?(error_message)).to be true
end