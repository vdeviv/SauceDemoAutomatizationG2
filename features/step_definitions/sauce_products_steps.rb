# step_definitions/sauce_products_steps.rb (REFATORIZADO)

# NO HAY require AQUÍ. La variable @product_page está lista.

# Paso para validar el conteo de ítems
Then('debo ver un total de {int} productos en la página') do |expected_count|
  # ✅ Usamos el método de ProductPage
  expect(@product_page.get_product_count).to eq(expected_count)
end

Then('el producto {string} debe tener el precio {string}') do |nombre_producto, precio_esperado|
  # ✅ Usamos el método de ProductPage
  info = @product_page.get_product_info(nombre_producto)
  expect(info[:price]).to eq(precio_esperado)
end

Then('el producto {string} debe tener la descripción {string}') do |nombre_producto, descripcion_esperada|
  # ✅ Usamos el método de ProductPage
  info = @product_page.get_product_info(nombre_producto)
  expect(info[:description]).to eq(descripcion_esperada)
end

Then('todas las imágenes de los productos deben ser visibles') do
  # ✅ Usamos el método de ProductPage (asumiendo que tiene la lógica de `all` y `be_visible`)
  # Nota: Si este método no existe en tu ProductPage, debes agregarlo.
  @product_page.all_images_are_visible? 
end

When('hago click en el nombre del producto {string}') do |nombre_producto|
  # ✅ Usamos el método de ProductPage
  @product_page.click_product_name(nombre_producto)
end

Then('deberia estar en la página de detalles del producto {string}') do |nombre_producto|
  # ✅ Usamos la validación de ProductPage y mantenemos la validación de URL
  expect(page).to have_current_path(/inventory-item\.html/)
  expect(@product_page.is_on_product_details_page?(nombre_producto)).to be true
end

When('hago click en el botón para volver a productos') do
  # ✅ Usamos el método de ProductPage
  @product_page.click_back_to_products
end

Then('veo los siguientes productos con sus detalles:') do |table|
  datos = table.hashes
  datos.each do |fila|
    # ✅ Usamos el método de ProductPage
    info = @product_page.get_product_info(fila['nombre'])
    expect(info[:price]).to eq(fila['precio'])
    expect(info[:description]).to include(fila['descripcion_parcial'])
  end
end