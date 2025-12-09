class ProductPage
  include Capybara::DSL

  PRODUCTS_TITLE = '.title'
  SHOPPING_CART_ICON = '.shopping_cart_link'
  SHOPPING_CART_BADGE = '.shopping_cart_badge'
  
  ADD_TO_CART_BUTTON = 'button[data-test^="add-to-cart"]' 
  

  def add_product_to_cart(product_name)

    product_card = find('.inventory_item', text: product_name, match: :first)

    product_card.find(ADD_TO_CART_BUTTON, text: 'Add to cart').click
  end
  
  def open_cart
    find(SHOPPING_CART_ICON).click
  end
  

  def cart_shows_count?(count)
    if count == "0"
      has_no_selector?(SHOPPING_CART_BADGE)
    else
      has_css?(SHOPPING_CART_BADGE, text: count, wait: 5)
    end
  end
  
  def product_button_shows?(product_name, button_text)
    product_card = find('.inventory_item', text: product_name, match: :first)
    product_card.has_button?(button_text)
  end
  
end