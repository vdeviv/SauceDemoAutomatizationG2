Given('estoy en la página de inicio de sesión') do
  visit '/' # Capybara usa la URL base definida en env.rb
end

When('ingreso el nombre de usuario {string}') do |username|
  fill_in 'user-name', with: username # 'user-name' es el ID del campo de usuario en Saucedemo
end

When('ingreso la contraseña {string}') do |password|
  fill_in 'password', with: password # 'password' es el ID del campo de contraseña
end

When('hago click en el botón {string}') do |button_name|
  click_button button_name
end

Then('soy redirigido a la página de productos') do
  # Verifica que la URL contenga 'inventory' y que se vea el título de la página.
  expect(page).to have_current_path('https://www.saucedemo.com/inventory.html')
  expect(page).to have_css('.title', text: 'Products')
end