# step_definitions/sauce_navbar_steps.rb (REFATORIZADO)

# NO HAY require AQUÍ. La variable @nav_menu_page está lista.

Given('estoy en la página de productos') do
   # Asumimos que la navegación y el login se manejan en saucelogin_steps.rb.
end

When('hago clic en el botón de menú') do
  # ✅ Usar @nav_menu_page directamente
  @nav_menu_page.open_menu
end

When('hago clic en el botón de {string}') do |button_name|
    # ✅ Usar @nav_menu_page directamente
    @nav_menu_page.click_menu_item(button_name)
end

Then('debo ver el botón de cerrar menú') do
    # ✅ Usar @nav_menu_page directamente
    expect(@nav_menu_page.close_menu_visible?).to be true
end

Then('debo ver los siguientes ítems del menú:') do |table|
    expected_items = table.raw.flatten
    # ✅ Usar @nav_menu_page directamente
    actual_items = @nav_menu_page.get_menu_items_text
    
    expect(actual_items).to match_array(expected_items)
end

# --- Verificaciones de Redirección (Se mantienen aquí) ---

Then('debo ser redirigido a la página de inicio de sesión') do
    expect(page).to have_selector('#login-button', visible: true)
    expect(page).to have_current_path('https://www.saucedemo.com/', wait: 5)
end

Then('debo ser redirigido al sitio web de Sauce Labs') do
    expect(page).to have_current_path(/saucelabs\.com/, url: true) 
end

Then('el carrito de compras debe estar vacío') do
    # ✅ Usamos el Page Object de Productos
    expect(@product_page.cart_shows_count?("0")).to be true 
end