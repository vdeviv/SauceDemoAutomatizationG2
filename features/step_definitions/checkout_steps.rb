# encoding: utf-8


When('ingreso los datos de envío:') do |table|
  if table.headers.include?('nombre') && table.headers.include?('apellido')
    datos = table.hashes.first 
  else
    datos = table.rows_hash
  end

  fill_in 'first-name', with: datos['nombre']
  fill_in 'last-name', with: datos['apellido']
  fill_in 'postal-code', with: datos['codigo_postal']
end


Then('deberia ver la información de pago {string}') do |info_pago|
  expect(page).to have_css('.summary_info', text: info_pago, wait: 5)
end

Then('deberia ver la información de envío {string}') do |info_envio|
  expect(page).to have_css('.summary_info', text: info_envio, wait: 5)
end


Then(/^el (subtotal|impuesto|monto total final) \("(.*?)"\) deberia ser "(.*?)"$/) do |tipo, label, monto_esperado|
  clase_css = case tipo
              when 'subtotal' then '.summary_subtotal_label'
              when 'impuesto' then '.summary_tax_label'
              when 'monto total final' then '.summary_total_label'
              end
  expect(page).to have_css(clase_css, text: label, wait: 5)
  expect(page).to have_css(clase_css, text: monto_esperado, wait: 5)
end


Then('deberia ver el encabezado {string}') do |titulo_esperado|
  expect(find('.title').text).to eq(titulo_esperado)
end

Then('deberia ver el mensaje de agradecimiento {string}') do |mensaje_esperado|
  expect(find('.complete-header').text).to eq(mensaje_esperado)
end

Then('el botón visible deberia ser {string}') do |texto_boton|
  expect(page).to have_button(texto_boton)
end


Then('deberia ver el error de checkout {string}') do |mensaje_error|
  expect(page).to have_css('[data-test="error"]', text: mensaje_error, wait: 5)
end
