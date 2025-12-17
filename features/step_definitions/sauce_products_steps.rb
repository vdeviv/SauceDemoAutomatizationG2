
Then('debo ver un total de {int} productos en la página') do |expected_count|
  expect(@product_page.get_product_count).to eq(expected_count)
end

Then('el producto {string} debe tener el precio {string}') do |nombre_producto, precio_esperado|

  info = @product_page.get_product_info(nombre_producto)
  expect(info[:price]).to eq(precio_esperado)
end

Then('el producto {string} debe tener la descripción {string}') do |nombre_producto, descripcion_esperada|

  info = @product_page.get_product_info(nombre_producto)
  expect(info[:description]).to eq(descripcion_esperada)
end

Then('todas las imágenes de los productos deben ser visibles') do
 
  @product_page.all_images_are_visible? 
end

When('hago click en el nombre del producto {string}') do |nombre_producto|

  @product_page.click_product_name(nombre_producto)
end

Then('deberia estar en la página de detalles del producto {string}') do |nombre_producto|

  expect(page).to have_current_path(/inventory-item\.html/)
  expect(@product_page.is_on_product_details_page?(nombre_producto)).to be true
end

When('hago click en el botón para volver a productos') do

  @product_page.click_back_to_products
end

Then('veo los siguientes productos con sus detalles:') do |table|
  datos = table.hashes
  datos.each do |fila|

    info = @product_page.get_product_info(fila['nombre'])
    expect(info[:price]).to eq(fila['precio'])
    expect(info[:description]).to include(fila['descripcion_parcial'])
  end
end
