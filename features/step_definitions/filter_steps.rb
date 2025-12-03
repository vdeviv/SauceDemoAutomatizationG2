# encoding: utf-8

# --- PRECONDICIÓN ---
Given('estoy en la página de inventario') do
  expect(page).to have_current_path('/inventory.html')
  expect(page).to have_css('.title', text: 'Products')
end

# --- ACCIÓN ---
When('selecciono la opción de ordenar por {string}') do |opcion_texto|
  # CORRECCIÓN:
  # En lugar de usar 'select ... from ...' (que busca por ID),
  # buscamos primero el elemento por su clase (.product_sort_container)
  # y luego buscamos la opción dentro de él.
  
  find('.product_sort_container').find('option', text: opcion_texto).select_option
  
  # Pequeña espera para asegurar el reordenamiento visual
  sleep 0.5 
end

# --- VALIDACIÓN (Lógica Compleja) ---
Then('los productos deberían ordenarse por {string}') do |criterio|
  # Mapeamos los selectores CSS
  selector_nombres = '.inventory_item_name'
  selector_precios = '.inventory_item_price'

  case criterio
  when 'nombre_asc'
    # Capturamos todos los textos de los nombres en un Array
    nombres_ui = all(selector_nombres).map(&:text)
    # Creamos una copia y la ordenamos por defecto (A-Z)
    nombres_esperados = nombres_ui.sort
    
    expect(nombres_ui).to eq(nombres_esperados)

  when 'nombre_desc'
    nombres_ui = all(selector_nombres).map(&:text)
    # Ordenamos y luego invertimos para Z-A
    nombres_esperados = nombres_ui.sort.reverse
    
    expect(nombres_ui).to eq(nombres_esperados)

  when 'precio_asc'
    # Capturamos textos, eliminamos el '$' y convertimos a Float para ordenar números correctamente
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