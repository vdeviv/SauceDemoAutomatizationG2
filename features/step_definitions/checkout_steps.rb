
When('ingreso los datos de envío:') do |table|
  if table.headers.include?('nombre') && table.headers.include?('apellido')
    datos = table.hashes.first 
  else
    datos = table.rows_hash
  end

  @checkout_page.ingresar_datos_envio(datos)
end


Then('deberia ver la información de pago {string}') do |info_pago|
  @checkout_page.verificar_info_resumen(info_pago)
end

Then('deberia ver la información de envío {string}') do |info_envio|
  @checkout_page.verificar_info_resumen(info_envio)
end


Then(/^el (subtotal|impuesto|monto total final) \("(.*?)"\) deberia ser "(.*?)"$/) do |tipo, label, monto_esperado|
  @checkout_page.verificar_monto(tipo, label, monto_esperado)
end

Then('el monto total debe ser calculado correctamente sumando subtotal e impuestos') do
  # Delegamos la obtención de valores a la página
  subtotal = @checkout_page.obtener_subtotal_numerico
  impuesto = @checkout_page.obtener_impuesto_numerico
  total_ui = @checkout_page.obtener_total_numerico

  # Calcular el total esperado
  total_calculado = (subtotal + impuesto).round(2)

  # Validar
  puts "Subtotal: #{subtotal} | Tax: #{impuesto} | Total UI: #{total_ui} | Calculado: #{total_calculado}"
  expect(total_ui).to eq(total_calculado)
end


Then('deberia ver el encabezado {string}') do |titulo_esperado|
  @checkout_page.verificar_encabezado(titulo_esperado)
end

Then('deberia ver el mensaje de agradecimiento {string}') do |mensaje_esperado|
  @checkout_page.verificar_mensaje_agradecimiento(mensaje_esperado)
end

Then('el botón visible deberia ser {string}') do |texto_boton|
  @checkout_page.verificar_boton_visible(texto_boton)
end


Then('deberia ver el error de checkout {string}') do |mensaje_error|
  @checkout_page.verificar_error_checkout(mensaje_error)
end
