# Paso para validar el conteo de ítems
Then('debo ver un total de {int} productos en la página') do |expected_count|
  # Usamos el selector CSS para encontrar todos los contenedores de productos.
  # La clase 'inventory_item' engloba cada producto en la lista.
  product_items = all('.inventory_item') 
  
  # Verificamos que el número de elementos encontrados sea exactamente el esperado (6)
  expect(product_items.count).to eq(expected_count)
end

Then('el producto {string} debe tener el precio {string}') do |nombre_producto, precio_esperado|
  producto = find('.inventory_item', text: nombre_producto)
  expect(producto).to have_css('.inventory_item_price', text: precio_esperado)
end

Then('el producto {string} debe tener la descripción {string}') do |nombre_producto, descripcion_esperada|
  producto = find('.inventory_item', text: nombre_producto)
  expect(producto).to have_css('.inventory_item_desc', text: descripcion_esperada)
end

Then('todas las imágenes de los productos deben ser visibles') do
  imagenes = all('.inventory_item_img img')
  imagenes.each do |img|
    expect(img).to be_visible
  end
end

When('hago click en el nombre del producto {string}') do |nombre_producto|
  find('.inventory_item_name', text: nombre_producto).click
end

Then('deberia estar en la página de detalles del producto {string}') do |nombre_producto|
  expect(page).to have_current_path(/inventory-item\.html/)
  expect(page).to have_css('.inventory_details_name', text: nombre_producto)
end

When('hago click en el botón para volver a productos') do
  find('#back-to-products').click
end

Then('veo los siguientes productos con sus detalles:') do |table|
  datos = table.hashes
  datos.each do |fila|
    producto = find('.inventory_item', text: fila['nombre'])
    expect(producto).to have_css('.inventory_item_price', text: fila['precio'])
    expect(producto).to have_css('.inventory_item_desc', text: fila['descripcion_parcial'])
  end
end