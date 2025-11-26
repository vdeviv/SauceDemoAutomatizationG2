Given('estoy en la página de inicio de sesión') do
  visit '/' 
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

# MODIFICACIÓN SUGERIDA en el paso "hago click en el botón de menú"
When('hago click en el botón de menú') do
  find('#react-burger-menu-btn').click
  # Agrega una espera explícita para que el enlace de Logout sea visible
  expect(page).to have_css('#logout_sidebar_link', visible: true, wait: 5) 
end

# Mantenemos este paso simple, confiando en que el anterior lo sincronizó
When('hago click en el enlace {string}') do |link_text|
  if link_text == "Logout"
    find('#logout_sidebar_link').click
  else
    click_link(link_text)
  end
    sleep 2

end

# MODIFICACIÓN SUGERIDA en el paso "soy redirigido a la página de inicio de sesión"
Then('soy redirigido a la página de inicio de sesión') do
  # La verificación debe ser la primera cosa que ocurre después del clic
  
  # Opción 1: Verifica la presencia del campo de usuario (elemento de la página de login)
  # Esto automáticamente espera a que la página cargue.
  expect(page).to have_field('user-name', wait: 5)
  
  # Opción 2 (Opcional): Verifica la URL
  expect(page).to have_current_path('https://www.saucedemo.com/', wait: 5)
  
  # Si el error persiste, la causa es que alguna configuración está cerrando la ventana.
end