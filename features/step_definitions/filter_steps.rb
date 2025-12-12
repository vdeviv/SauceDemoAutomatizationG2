Given('estoy en la página de inventario') do

  expect(@product_page.is_on_product_page?).to be true 
end

When('selecciono la opción de ordenar por {string}') do |opcion_texto|

  @filter_page.select_sort_option(opcion_texto)
  
  sleep 0.5 
end


Then('los productos deberían ordenarse por {string}') do |criterio|
  
  case criterio
  when 'nombre_asc'

    nombres_ui = @filter_page.get_visible_product_names 
    nombres_esperados = nombres_ui.sort
    
    expect(nombres_ui).to eq(nombres_esperados), "Los nombres no están ordenados de A a Z."

  when 'nombre_desc'
    nombres_ui = @filter_page.get_visible_product_names 
    nombres_esperados = nombres_ui.sort.reverse
    
    expect(nombres_ui).to eq(nombres_esperados), "Los nombres no están ordenados de Z a A."

  when 'precio_asc'
    precios_ui = @filter_page.get_visible_product_prices
    precios_esperados = precios_ui.sort
    
    expect(precios_ui).to eq(precios_esperados), "Los precios no están ordenados de menor a mayor."

  when 'precio_desc'
    precios_ui = @filter_page.get_visible_product_prices
    precios_esperados = precios_ui.sort.reverse
    
    expect(precios_ui).to eq(precios_esperados), "Los precios no están ordenados de mayor a menor."

  else
    raise "Criterio de ordenamiento no reconocido: #{criterio}"
  end
end