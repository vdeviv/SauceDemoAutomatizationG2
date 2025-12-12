class CartPage
  include Capybara::DSL

  CART_TITLE = '.title'
  CART_ITEM = '.cart_item' 
  CONTINUE_SHOPPING_BUTTON = '#continue-shopping'
  CHECKOUT_BUTTON = '#checkout'
  


  def remove_item(product_name)

    item = find(CART_ITEM, text: product_name, match: :first)
    item.find('button', text: 'Remove').click
  end
  
  def click_navigation_button(button_name)
    case button_name
    when "Continue Shopping"
      find(CONTINUE_SHOPPING_BUTTON).click
    when "Checkout"
      find(CHECKOUT_BUTTON).click
    else
      click_button(button_name) 
    end
  end
  

  def verify_cart_items_details(expected_items)
    expected_items.each do |item|
      cart_item = find(CART_ITEM, text: item['nombre'])
      expect(cart_item).to have_css('.cart_quantity', text: item['cantidad'])
      expect(cart_item).to have_css('.inventory_item_price', text: item['precio'])

      expect(cart_item).to have_css('.inventory_item_desc', text: item['descripcion_parcial'])
    end
  end
  
  def item_is_removed?(product_name)
    has_no_css?(CART_ITEM, text: product_name, wait: 3)
  end
  
  def item_is_present?(product_name)
    has_css?(CART_ITEM, text: product_name, wait: 3)
  end
  
  def is_empty?
    has_no_css?(CART_ITEM, wait: 3)
  end

  def get_cart_items_details
  all(CART_ITEM).map do |item|
    {
      'cantidad' => item.find('.cart_quantity').text,
      'nombre' => item.find('.inventory_item_name').text,
      'precio' => item.find('.inventory_item_price').text,
      'descripcion_parcial' => item.find('.inventory_item_desc').text
    }
  end
end
  
end