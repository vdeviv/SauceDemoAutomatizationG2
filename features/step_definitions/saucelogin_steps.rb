
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
  @login_page.click_login_button
end

Then('soy redirigido a la página de productos') do
  expect(@login_page.expected_title_displayed?('Products')).to be true
end

When('hago click en el botón de menú') do
  # ✅ Usamos la instancia @nav_menu_page (inicializada en hooks)
  @nav_menu_page.open_menu
end

When('hago click en el enlace {string}') do |link_text|
  # ✅ Usamos la instancia @nav_menu_page
  @nav_menu_page.click_menu_item(link_text)
end

Then('soy redirigido a la página de inicio de sesión') do
  # ✅ Usamos el método de validación de LoginPage
  expect(@login_page.is_on_login_page?).to be true
end

Then('veo el mensaje de error de login {string}') do |error_message|
  # ✅ Usamos el método de validación de LoginPage
  expect(@login_page.error_message_is_visible?(error_message)).to be true
end