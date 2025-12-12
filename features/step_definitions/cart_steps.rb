# step_definitions/cart_steps.rb (REFATORIZADO)

# NO HAY require AQUÍ. Las variables @product_page y @cart_page están listas.

Given('agrego el producto {string} al carrito') do |nombre_producto|
  # ✅ Usar @product_page directamente
  @product_page.add_product_to_cart(nombre_producto)
end


When('hago click en el icono del carrito') do
  # ✅ Usar @product_page directamente
  @product_page.open_cart
end

When('abro el carrito') do
  # ✅ Usar @product_page directamente
  @product_page.open_cart
end

Then('veo los siguientes items en la lista del carrito:') do |table|
  # ✅ Usar @cart_page directamente
  actual_items = @cart_page.get_cart_items_details
  
  expected_items = table.hashes
  
  # La lógica de aserción se mantiene, usando los datos del PO
  expect(actual_items.size).to eq(expected_items.size), "Número incorrecto de items en el carrito."
  
  expected_items.each do |expected|
    match = actual_items.find do |actual|
      actual['nombre'] == expected['nombre'] &&
      actual['cantidad'] == expected['cantidad'] &&
      actual['precio'] == expected['precio'] &&
      actual['descripcion_parcial'].include?(expected['descripcion_parcial']) 
    end
    expect(match).not_to be_nil, "No se encontró el ítem: #{expected['nombre']} con los detalles correctos."
  end
end

Then('el icono del carrito muestra {string}') do |cantidad_esperada|
  # ✅ Usar @product_page directamente
  expect(@product_page.cart_shows_count?(cantidad_esperada)).to be true
end

When('hago click en el botón "Remove" del producto {string}') do |nombre_producto|
  # ✅ Usar @cart_page directamente
  @cart_page.remove_item(nombre_producto)
end

When('elimino el producto {string} del carrito') do |nombre_producto|
  # ✅ Usar @cart_page directamente
  @cart_page.remove_item(nombre_producto)
end

Then('el producto {string} no debería aparecer en la lista') do |nombre_producto|
  # ✅ Usar @cart_page directamente
  expect(@cart_page.item_is_removed?(nombre_producto)).to be true
end

Then('el producto {string} debería seguir en la lista') do |nombre_producto|
  # ✅ Usar @cart_page directamente
  expect(@cart_page.item_is_present?(nombre_producto)).to be true
end

Then('la lista de items del carrito debería estar vacía') do
  # ✅ Usar @cart_page directamente
  expect(@cart_page.is_empty?).to be true
end

Then('el carrito deberia estar vacio') do
  # ✅ Usar @product_page y @cart_page
  expect(@product_page.cart_shows_count?("0")).to be true
  expect(@cart_page.is_empty?).to be true
end

Then('el icono del carrito no debería mostrar ningún número') do
  # ✅ Usar @product_page
  expect(@product_page.cart_shows_count?("0")).to be true
end

Then('el boton del producto {string} debe mostrar {string}') do |nombre_producto, texto_boton|
  # ✅ Usar @product_page
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