Given('estoy en la página de inicio de sesión') do
  visit '/' 
end

When('ingreso el nombre de usuario {string}') do |username|
  fill_in 'user-name', with: username 
end

When('ingreso la contraseña {string}') do |password|
  fill_in 'password', with: password 

end

When('hago click en el botón {string}') do |button_name|
  click_button button_name
end

Then('soy redirigido a la página de productos') do
  expect(page).to have_current_path('https://www.saucedemo.com/inventory.html') #preguntar /
  expect(page).to have_css('.title', text: 'Products')
end

When('hago click en el botón de menú') do
  find('#react-burger-menu-btn').click
  expect(page).to have_css('#logout_sidebar_link', visible: true, wait: 5) 
end

When('hago click en el enlace {string}') do |link_text|
  if link_text == "Logout"
    find('#logout_sidebar_link').click
  else
    click_link(link_text)
  end

end

Then('soy redirigido a la página de inicio de sesión') do
 
  expect(page).to have_field('user-name', wait: 5)
  
  expect(page).to have_current_path('https://www.saucedemo.com/', wait: 5)
  
end

Then('veo el mensaje de error de login {string}') do |error_message|
  # Este paso verifica el mensaje de error en la clase CSS usada por SauceDemo para errores.
  expect(page).to have_css('.error-message-container.error', text: error_message, wait: 5)
end