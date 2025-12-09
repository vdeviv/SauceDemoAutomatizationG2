Given('estoy en la página de inventario') do

  expect(@product_page.is_on_product_page?).to be true 
end

When('selecciono la opción de ordenar por {string}') do |opcion_texto|

  @filter_page.select_sort_option(opcion_texto)
  
  sleep 0.5 
end


Then('los productos deberían ordenarse por {string}') do |criterio|
  
  items = all('.inventory_item')
  
  case criterio
  when 'nombre_asc'
    nombres_ui = items.map { |item| item.find('.inventory_item_name').text }
    nombres_esperados = nombres_ui.sort
    
    expect(nombres_ui).to eq(nombres_esperados), "La lista visual de productos no está ordenada alfabéticamente (A-Z)."

  when 'nombre_desc'
    nombres_ui = items.map { |item| item.find('.inventory_item_name').text }
    nombres_esperados = nombres_ui.sort.reverse
    
    expect(nombres_ui).to eq(nombres_esperados), "La lista visual de productos no está ordenada alfabéticamente (Z-A)."

  when 'precio_asc'
    precios_ui = items.map { |item| item.find('.inventory_item_price').text.gsub('$', '').to_f }
    precios_esperados = precios_ui.sort
    
    expect(precios_ui).to eq(precios_esperados), "La lista visual de precios no está ordenada de menor a mayor."

  when 'precio_desc'
    precios_ui = items.map { |item| item.find('.inventory_item_price').text.gsub('$', '').to_f }
    precios_esperados = precios_ui.sort.reverse
    
    expect(precios_ui).to eq(precios_esperados), "La lista visual de precios no está ordenada de mayor a menor."

  else
    raise "Criterio de ordenamiento no reconocido: #{criterio}"
  end
end