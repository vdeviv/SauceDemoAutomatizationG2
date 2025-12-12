
Given('estoy en la página de productos') do

end

When('hago clic en el botón de menú') do

    @nav_menu_page.open_menu
end

When('hago clic en el botón de {string}') do |button_name|

    @nav_menu_page.click_menu_item(button_name)
end

Then('debo ver el botón de cerrar menú') do

    expect(@nav_menu_page.close_menu_visible?).to be true
end

Then('debo ver los siguientes ítems del menú:') do |table|
    expected_items = table.raw.flatten

    actual_items = @nav_menu_page.get_menu_items_text
    
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

    expect(@product_page.cart_shows_count?("0")).to be true 
end