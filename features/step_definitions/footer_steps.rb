Given('hago scroll hasta el final de la página') do
  page.execute_script "window.scrollTo(0, document.body.scrollHeight)"
end

When('hago click en el icono de {string}') do |red_social|
  clase_css = case red_social
              when 'Twitter' then '.social_twitter a'
              when 'Facebook' then '.social_facebook a'
              when 'LinkedIn' then '.social_linkedin a'
              else raise "Red social no reconocida: #{red_social}"
              end

  find(clase_css).click
end


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
  footer_text = find('.footer_copy').text
  expect(footer_text).to include(texto_esperado)
end


Then('se debería abrir una nueva pestaña con la URL {string}') do |url_esperada|
  expect(page.driver.browser.window_handles.length).to be > 1
  
  ventana_nueva = page.driver.browser.window_handles.last
  page.driver.browser.switch_to.window(ventana_nueva)

  puts "URL Actual en nueva pestaña: #{current_url}" 

  
  if url_esperada.include?("facebook")
    expect(current_url).to include("facebook.com")
  elsif url_esperada.include?("linkedin")
    expect(current_url).to include("linkedin.com")
  else
    expect(current_url).to include(url_esperada)
  end

  page.driver.browser.close
  page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
end