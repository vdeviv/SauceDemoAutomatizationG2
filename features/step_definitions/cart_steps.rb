# encoding: utf-8


Given('agrego el producto {string} al carrito') do |nombre_producto|
  producto_card = find('.inventory_item', text: nombre_producto)
  producto_card.find('button', text: 'Add to cart').click
end


When('hago click en el icono del carrito') do
  find('.shopping_cart_link').click
end

When('abro el carrito') do
  find('.shopping_cart_link').click
end


Then('veo los siguientes items en la lista del carrito:') do |table|
  datos = table.hashes
  datos.each do |fila|
    item_carrito = find('.cart_item', text: fila['nombre'])
    expect(item_carrito).to have_css('.cart_quantity', text: fila['cantidad'])
    expect(item_carrito).to have_css('.inventory_item_price', text: fila['precio'])
    expect(item_carrito).to have_css('.inventory_item_desc', text: fila['descripcion_parcial'])
  end
end


Then('el icono del carrito muestra {string}') do |cantidad_esperada|
  expect(page).to have_css('.shopping_cart_badge', text: cantidad_esperada)
end

When('hago click en el botón "Remove" del producto {string}') do |nombre_producto|
  item = find('.cart_item', text: nombre_producto)
  item.find('button', text: 'Remove').click
end

When('elimino el producto {string} del carrito') do |nombre_producto|
  if page.has_css?('.cart_item', text: nombre_producto)
    item = find('.cart_item', text: nombre_producto)
    item.find('button', text: 'Remove').click
  else
    producto_card = find('.inventory_item', text: nombre_producto)
    producto_card.find('button', text: 'Remove').click
  end
end

Then('el producto {string} no debería aparecer en la lista') do |nombre_producto|
  expect(page).to have_no_css('.cart_item', text: nombre_producto)
end

Then('el producto {string} debería seguir en la lista') do |nombre_producto|
  expect(page).to have_css('.cart_item', text: nombre_producto)
end

Then('la lista de items del carrito debería estar vacía') do
  expect(page).to have_no_css('.cart_item')
end

Then('el carrito deberia estar vacio') do
  expect(page).to have_no_css('.shopping_cart_badge')
end

Then('el icono del carrito no debería mostrar ningún número') do
  expect(page).to have_no_css('.shopping_cart_badge')
end

Then('el boton del producto {string} debe mostrar {string}') do |nombre_producto, texto_boton|
  producto_card = find('.inventory_item', text: nombre_producto)
  expect(producto_card).to have_button(texto_boton)
end


Then('debería ser redirigido a la página {string}') do |pagina_esperada|
  url_parcial = case pagina_esperada
                when 'Inventory' then 'inventory.html'
                when 'Checkout Step One' then 'checkout-step-one.html'
                else
                  raise "Página desconocida: #{pagina_esperada}"
                end
  expect(current_url).to include(url_parcial)
end
