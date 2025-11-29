
Given('estoy en la página de productos') do
   
    nav_menu.visit_inventory_page 
end

When('hago clic en el botón de menú') do
    nav_menu.click_menu_button
end

When('hago clic en el botón de {string}') do |button_name|
    case button_name
    when "Logout"
        nav_menu.click_logout_button
    when "About"
        nav_menu.click_about_button
    when "Reset App State"
        nav_menu.click_reset_app_state_button
    else
        raise "Botón no reconocido en el menú: #{button_name}"
    end
end

Then('debo ver el botón de cerrar menú') do

    expect(page).to have_selector('#react-burger-cross-btn', visible: true)
end

Then('debo ver los siguientes ítems del menú:') do |table|
    expected_items = table.raw.flatten
    actual_items = nav_menu.get_menu_items
    expect(actual_items).to match_array(expected_items)
end

Then('debo ser redirigido a la página de inicio de sesión') do
    expect(page).to have_selector('#login-button', visible: true)
end

Then('debo ser redirigido al sitio web de Sauce Labs') do
    # Ajustamos el 'wait' para ser consistente con Capybara default wait
    expect(page).to have_current_path(/saucelabs\.com/, url: true) 
end

Then('el carrito de compras debe estar vacío') do
    expect(page).to have_no_selector('.shopping_cart_badge')
end