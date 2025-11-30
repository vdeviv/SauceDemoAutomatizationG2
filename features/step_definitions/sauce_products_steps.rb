# Paso para validar el conteo de ítems
Then('debo ver un total de {int} productos en la página') do |expected_count|
  # Usamos el selector CSS para encontrar todos los contenedores de productos.
  # La clase 'inventory_item' engloba cada producto en la lista.
  product_items = all('.inventory_item') 
  
  # Verificamos que el número de elementos encontrados sea exactamente el esperado (6)
  expect(product_items.count).to eq(expected_count)
end