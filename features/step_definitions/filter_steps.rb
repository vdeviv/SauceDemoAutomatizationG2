Given('estoy en la página de inventario') do
  expect(page).to have_current_path('/inventory.html')
  expect(page).to have_css('.title', text: 'Products')
end

When('selecciono la opción de ordenar por {string}') do |opcion_texto|
  find('.product_sort_container').find('option', text: opcion_texto).select_option

  sleep 0.5 
end

Then('los productos deberían ordenarse por {string}') do |criterio|
  selector_nombres = '.inventory_item_name'
  selector_precios = '.inventory_item_price'

  case criterio
  when 'nombre_asc'
    nombres_ui = all(selector_nombres).map(&:text)
    nombres_esperados = nombres_ui.sort
    
    expect(nombres_ui).to eq(nombres_esperados)

  when 'nombre_desc'
    nombres_ui = all(selector_nombres).map(&:text)
    nombres_esperados = nombres_ui.sort.reverse
    
    expect(nombres_ui).to eq(nombres_esperados)

  when 'precio_asc'
    precios_ui = all(selector_precios).map { |el| el.text.gsub('$', '').to_f }
    
    precios_esperados = precios_ui.sort
    expect(precios_ui).to eq(precios_esperados)

  when 'precio_desc'
    precios_ui = all(selector_precios).map { |el| el.text.gsub('$', '').to_f }
    
    precios_esperados = precios_ui.sort.reverse
    expect(precios_ui).to eq(precios_esperados)

  else
    raise "Criterio de ordenamiento no reconocido: #{criterio}"
  end
end