Then('deberia ver exactamente estos productos en la lista:') do |table|
  nombres_esperados = table.raw.flatten

  elementos_encontrados = all('.inventory_item_name')

  nombres_reales = elementos_encontrados.map(&:text)
  expect(nombres_reales.count).to eq(nombres_esperados.count), 
    "Se esperaban #{nombres_esperados.count} productos, pero se encontraron #{nombres_reales.count}"
  expect(nombres_reales).to match_array(nombres_esperados)
end