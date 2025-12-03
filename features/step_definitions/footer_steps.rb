# encoding: utf-8

# --- ACCIONES ---

Given('hago scroll hasta el final de la página') do
  # Ejecutamos Javascript para bajar hasta el fondo
  page.execute_script "window.scrollTo(0, document.body.scrollHeight)"
end

When('hago click en el icono de {string}') do |red_social|
  # Mapeamos el nombre legible al selector CSS específico de SauceDemo
  clase_css = case red_social
              when 'Twitter' then '.social_twitter a'
              when 'Facebook' then '.social_facebook a'
              when 'LinkedIn' then '.social_linkedin a'
              else raise "Red social no reconocida: #{red_social}"
              end
  
  # Buscamos el elemento y hacemos click
  find(clase_css).click
end

# --- VALIDACIONES VISUALES ---

Then('debería ver los iconos de redes sociales:') do |table|
  redes = table.raw.flatten
  
  redes.each do |red|
    clase_css = case red
                when 'Twitter' then '.social_twitter'
                when 'Facebook' then '.social_facebook'
                when 'LinkedIn' then '.social_linkedin'
                end
    expect(page).to have_css(clase_css, visible: true)
  end
end

Then('debería ver el texto de copyright {string}') do |texto_esperado|
  # Usamos una validación flexible (include) por si el año cambia
  footer_text = find('.footer_copy').text
  expect(footer_text).to include(texto_esperado)
end

# --- VALIDACIÓN TÉCNICA (NUEVA PESTAÑA) ---

Then('se debería abrir una nueva pestaña con la URL {string}') do |url_esperada|
  expect(page.driver.browser.window_handles.length).to be > 1
  
  ventana_nueva = page.driver.browser.window_handles.last
  page.driver.browser.switch_to.window(ventana_nueva)

  puts "URL Actual en nueva pestaña: #{current_url}" # Para depuración

  # --- LÓGICA DE VALIDACIÓN FLEXIBLE ---
  # Facebook y LinkedIn a menudo redirigen al login cuando detectan automatización.
  # Por eso, validamos que estemos en el DOMINIO correcto, no la URL exacta completa.
  
  if url_esperada.include?("facebook")
    expect(current_url).to include("facebook.com")
  elsif url_esperada.include?("linkedin")
    expect(current_url).to include("linkedin.com")
  else
    # Para otros casos (como X/Twitter), mantenemos la validación estricta
    expect(current_url).to include(url_esperada)
  end

  page.driver.browser.close
  page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
end