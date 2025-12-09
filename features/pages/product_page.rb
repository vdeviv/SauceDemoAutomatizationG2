class ProductPage
  include Capybara::DSL

  PRODUCTS_TITLE = '.title'
  SHOPPING_CART_ICON = '.shopping_cart_link'
  SHOPPING_CART_BADGE = '.shopping_cart_badge'
  
  ADD_TO_CART_BUTTON = 'button[data-test^="add-to-cart"]' 

  def is_on_product_page?

    has_css?(PRODUCTS_TITLE, text: 'Products', wait: 5)
  end

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

  def get_product_count
    all('.inventory_item').count
  end

  def get_product_info(product_name)
    product = find('.inventory_item', text: product_name)
    price = product.find('.inventory_item_price').text
    description = product.find('.inventory_item_desc').text
    { price: price, description: description }
  end

  def all_images_are_visible?
    all('.inventory_item_img img').each do |img|
      raise "Imagen no visible" unless img.visible?
    end
  end

  def click_product_name(product_name)
    find('.inventory_item_name', text: product_name).click
  end

  def is_on_product_details_page?(product_name)
    has_css?('.inventory_details_name', text: product_name)
  end

  def click_back_to_products
    find('#back-to-products').click
  end
  
end