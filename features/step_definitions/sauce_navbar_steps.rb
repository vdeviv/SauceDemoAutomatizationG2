
Given('estoy en la página de productos') do

end

When('hago clic en el botón de menú') do

    @nav_menu_page.open_menu
end

When('hago clic en el botón de {string}') do |button_name|

    @nav_menu_page.click_menu_item(button_name)
end

Then('debo ver el botón de cerrar menú') do

    expect(page).to have_selector('#react-burger-cross-btn', visible: true)
end

Then('debo ver los siguientes ítems del menú:') do |table|
    expected_items = table.raw.flatten

    actual_items = @nav_menu_page.get_menu_items_text
    
    expect(actual_items).to match_array(expected_items)
end


Then('debo ser redirigido a la página de inicio de sesión') do
    expect(find('.login_logo').text).to eq('Swag Labs')
    expect(page).to have_selector('#login-button', visible: true)
    expect(page).to have_current_path('https://www.saucedemo.com/', wait: 5)
end

Then('debo ser redirigido al sitio web de Sauce Labs') do
  expect(page).to have_content('Solutions', wait: 15) 
  expect(page.title).to include('Sauce Labs')
end

Then('el carrito de compras debe estar vacío') do
  expect(page).not_to have_selector('.shopping_cart_badge')
end