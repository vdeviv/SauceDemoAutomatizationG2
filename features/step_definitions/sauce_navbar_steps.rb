# step_definitions/sauce_navbar_steps.rb

# Requiere el Page Object (esto es posible gracias a la configuración en env.rb)
require 'nav_menu_page' 
# Opcionalmente, podrías crear una PageBase o instanciar globalmente, 
# pero para empezar, instanciar en cada paso es claro.

# Se asume que este 'Given' ahora viene de saucelogin_steps.rb o se usa aquí para contexto
Given('estoy en la página de productos') do
   # Asumimos que la navegación y el login se manejan en otra parte.
   # Si este paso va en este archivo, déjalo sin contenido si el login ya lo valida.
end

When('hago clic en el botón de menú') do
  # 1. Instanciar la clase de página (Page Object)
  @nav_menu = NavMenuPage.new 
  # 2. Llamar al método de la Page Object
  @nav_menu.open_menu
end

When('hago clic en el botón de {string}') do |button_name|
    @nav_menu ||= NavMenuPage.new # Asegura que la Page Object esté instanciada
    # Llamar al método para hacer clic en el ítem
    @nav_menu.click_menu_item(button_name)
end

Then('debo ver el botón de cerrar menú') do
    @nav_menu ||= NavMenuPage.new
    # Usar el método de verificación
    expect(@nav_menu.close_menu_visible?).to be true
end

Then('debo ver los siguientes ítems del menú:') do |table|
    expected_items = table.raw.flatten
    @nav_menu ||= NavMenuPage.new
    # Usar el método para obtener los ítems actuales
    actual_items = @nav_menu.get_menu_items_text
    
    expect(actual_items).to match_array(expected_items)
end

# Los siguientes pasos ('debo ser redirigido a la página de inicio de sesión' y otros) 
# deberían manejarse en las Page Objects de Login, o en un BaseSteps si se reusan mucho.
# Por ahora, los dejamos para no sobrecomplicar la refactorización inicial.
# Si estos pasos son *verificaciones de redirección*, puedes dejarlos en los pasos.
Then('debo ser redirigido a la página de inicio de sesión') do
    expect(page).to have_selector('#login-button', visible: true)
    expect(page).to have_current_path('https://www.saucedemo.com/', wait: 5)
end

Then('debo ser redirigido al sitio web de Sauce Labs') do
    expect(page).to have_current_path(/saucelabs\.com/, url: true) 
end

Then('el carrito de compras debe estar vacío') do
    # Este paso es una buena candidata para un Page Object de Carrito o Productos.
    expect(page).to have_no_selector('.shopping_cart_badge')
end