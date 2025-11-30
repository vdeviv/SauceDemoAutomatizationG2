# Paso de inicialización (Si estás usando un Page Object Model)
# Si no usas nav_menu, debes reemplazar nav_menu.click_... por find('#id').click
# Asumiendo que 'nav_menu' es un objeto que ya inicializaste.

Given('estoy en la página de productos') do
    # Este paso parece ser redundante si usas el Background del feature.
    # nav_menu.visit_inventory_page 
end

# **[1] NUEVO PASO AÑADIDO: Define el clic para abrir el menú**
When('hago clic en el botón de menú') do
  find('#react-burger-menu-btn').click
  # Esperamos a que el menú lateral (sidebar) sea visible
  expect(page).to have_css('#menu_button_container', visible: true, wait: 5) 
end

# **[2] PASO CORREGIDO: Define el clic dentro del menú usando IDs**
When('hago clic en el botón de {string}') do |button_name|
    case button_name
    when "Logout"
        # Usar el selector directo o el método POM
        find('#logout_sidebar_link').click
        # nav_menu.click_logout_button
    when "About"
        find('#about_sidebar_link').click
        # nav_menu.click_about_button
    when "Reset App State"
        find('#reset_sidebar_link').click
        # nav_menu.click_reset_app_state_button
    else
        # Esto intenta buscar por texto si no es ninguno de los anteriores
        find('nav a', text: button_name).click
    end
end

Then('debo ver el botón de cerrar menú') do
    expect(page).to have_selector('#react-burger-cross-btn', visible: true)
end

# Este paso asume que nav_menu.get_menu_items devuelve un array de los textos de los enlaces.
Then('debo ver los siguientes ítems del menú:') do |table|
    expected_items = table.raw.flatten
    
    # Selector directo para obtener los textos de los ítems del menú (si no usas nav_menu)
    actual_items = all('.bm-item-list a').map(&:text)
    
    expect(actual_items).to match_array(expected_items)
end

Then('debo ser redirigido a la página de inicio de sesión') do
    expect(page).to have_selector('#login-button', visible: true)
    expect(page).to have_current_path('https://www.saucedemo.com/', wait: 5)
end

Then('debo ser redirigido al sitio web de Sauce Labs') do
    # El sitio About redirecciona a https://saucelabs.com/
    expect(page).to have_current_path(/saucelabs\.com/, url: true) 
end

Then('el carrito de compras debe estar vacío') do
    # Verifica que el badge del carrito no esté presente
    expect(page).to have_no_selector('.shopping_cart_badge')
end