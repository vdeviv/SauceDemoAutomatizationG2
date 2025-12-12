
Given('hago scroll hasta el final de la página') do

  @footer_page.scroll_to_footer
end

When('hago click en el icono de {string}') do |red_social|

  @footer_page.click_social_icon(red_social)
end


Then('debería ver los iconos de redes sociales:') do |table|

  redes = table.raw.flatten 
  
  redes.each do |red|
   raise "El icono de #{red} no es visible." unless @footer_page.social_icon_is_visible?(red)
  end
end

Then('debería ver el texto de copyright {string}') do |texto_esperado|

  expect(@footer_page.verify_copyright_text(texto_esperado)).to be true
end


Then('se debería abrir una nueva pestaña con la URL {string}') do |url_esperada|

  expect(@footer_page.validate_new_window_url(url_esperada)).to be true
end