
require 'product_page' 
require 'cart_page' 


Given('agrego el producto {string} al carrito') do |nombre_producto|
  @product_page ||= ProductPage.new

  @product_page.add_product_to_cart(nombre_producto)
end


When('hago click en el icono del carrito') do
  @product_page ||= ProductPage.new

  @product_page.open_cart
end

When('abro el carrito') do

  @product_page ||= ProductPage.new
  @product_page.open_cart
end

Then('veo los siguientes items en la lista del carrito:') do |table|
  @cart_page ||= CartPage.new
  
  # 1. Obtiene los datos reales de la página
  actual_items = @cart_page.get_cart_items_details
  
  # 2. Obtiene los datos esperados de la tabla Gherkin
  expected_items = table.hashes
  
  # 3. Realiza la aserción en el Step Definition (donde 'expect' existe)
  expect(actual_items.size).to eq(expected_items.size), "Número incorrecto de items en el carrito."
  
  # 4. Verifica que cada item esperado esté presente en los items reales (con todos sus detalles)
  expected_items.each do |expected|
    match = actual_items.find do |actual|
      actual['nombre'] == expected['nombre'] &&
      actual['cantidad'] == expected['cantidad'] &&
      actual['precio'] == expected['precio'] &&
      actual['descripcion_parcial'].include?(expected['descripcion_parcial']) # Usamos include para la descripción parcial
    end
    expect(match).not_to be_nil, "No se encontró el ítem: #{expected['nombre']} con los detalles correctos."
  end
end

Then('el icono del carrito muestra {string}') do |cantidad_esperada|
  @product_page ||= ProductPage.new
  expect(@product_page.cart_shows_count?(cantidad_esperada)).to be true
end

When('hago click en el botón "Remove" del producto {string}') do |nombre_producto|
  @cart_page ||= CartPage.new
  @cart_page.remove_item(nombre_producto)
end

When('elimino el producto {string} del carrito') do |nombre_producto|

  @cart_page ||= CartPage.new
  @cart_page.remove_item(nombre_producto)
end

Then('el producto {string} no debería aparecer en la lista') do |nombre_producto|
  @cart_page ||= CartPage.new
  expect(@cart_page.item_is_removed?(nombre_producto)).to be true
end

Then('el producto {string} debería seguir en la lista') do |nombre_producto|
  @cart_page ||= CartPage.new
  expect(@cart_page.item_is_present?(nombre_producto)).to be true
end

Then('la lista de items del carrito debería estar vacía') do
  @cart_page ||= CartPage.new
  expect(@cart_page.is_empty?).to be true
end

Then('el carrito deberia estar vacio') do
  @product_page ||= ProductPage.new
  expect(@product_page.cart_shows_count?("0")).to be true
  
  @cart_page ||= CartPage.new
  expect(@cart_page.is_empty?).to be true
end

Then('el icono del carrito no debería mostrar ningún número') do
  @product_page ||= ProductPage.new
  expect(@product_page.cart_shows_count?("0")).to be true
end

Then('el boton del producto {string} debe mostrar {string}') do |nombre_producto, texto_boton|
  @product_page ||= ProductPage.new
  expect(@product_page.product_button_shows?(nombre_producto, texto_boton)).to be true
end


Then('deberia ser redirigido a la página {string}') do |pagina_esperada|
  url_parcial = case pagina_esperada
                when 'Inventory' then 'inventory.html'
                when 'Checkout Step One' then 'checkout-step-one.html'
                else
                  raise "Página desconocida: #{pagina_esperada}"
                end
              
  expect(current_url).to include(url_parcial)
end
