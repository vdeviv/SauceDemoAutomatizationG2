When('agrego el producto {string} al carrito') do |product_name|
  # Convierte "Sauce Labs Backpack" a "add-to-cart-sauce-labs-backpack"
  product_id_suffix = product_name.downcase.gsub(' ', '-')
  button_id = "add-to-cart-#{product_id_suffix}"
  click_button(button_id)
end

Then('el icono del carrito muestra {string}') do |expected_count|
  expect(page).to have_css('#shopping_cart_container > a > span', text: expected_count)
end