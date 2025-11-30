
Given('estoy en la página de productos') do
   
end

When('hago clic en el botón de menú') do
  find('#react-burger-menu-btn').click
  expect(page).to have_css('#menu_button_container', visible: true, wait: 5) 
end

When('hago clic en el botón de {string}') do |button_name|
    case button_name
    when "Logout"
        find('#logout_sidebar_link').click
    when "About"
        find('#about_sidebar_link').click
    when "Reset App State"
        find('#reset_sidebar_link').click
    else
        find('nav a', text: button_name).click
    end
end

Then('debo ver el botón de cerrar menú') do
    expect(page).to have_selector('#react-burger-cross-btn', visible: true)
end

Then('debo ver los siguientes ítems del menú:') do |table|
    expected_items = table.raw.flatten
    
    actual_items = all('.bm-item-list a').map(&:text)
    
    expect(actual_items).to match_array(expected_items)
end

Then('debo ser redirigido a la página de inicio de sesión') do
    expect(page).to have_selector('#login-button', visible: true)
    expect(page).to have_current_path('https://www.saucedemo.com/', wait: 5)
end

Then('debo ser redirigido al sitio web de Sauce Labs') do
    expect(page).to have_current_path(/saucelabs\.com/, url: true) 
end

Then('el carrito de compras debe estar vacío') do
    expect(page).to have_no_selector('.shopping_cart_badge')
end