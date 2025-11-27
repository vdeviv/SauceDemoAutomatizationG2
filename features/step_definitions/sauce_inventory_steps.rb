When('agrego el producto {string} al carrito') do |product_name|
  product_id_suffix = product_name.downcase.gsub(' ', '-')
  button_id = "add-to-cart-#{product_id_suffix}"
  click_button(button_id)
      sleep 2

end

Then('el icono del carrito muestra {string}') do |expected_count|
  expect(page).to have_css('#shopping_cart_container > a > span', text: expected_count)
end

When('elimino el producto {string} del carrito') do |product_name|
  product_id_suffix = product_name.downcase.gsub(' ', '-')
  button_id = "remove-#{product_id_suffix}"
  click_button(button_id)
      sleep 2

end

Then('el carrito deberia estar vacio') do
  expect(page).not_to have_css('#shopping_cart_container > a > span')
      sleep 2

end