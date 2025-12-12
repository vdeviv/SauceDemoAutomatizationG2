class FilterPage
  include Capybara::DSL

  PRODUCT_SORT_DROPDOWN = '.product_sort_container'
  
  INVENTORY_ITEM_NAME   = '.inventory_item_name'
  INVENTORY_ITEM_PRICE  = '.inventory_item_price'
  
  
  def select_sort_option(option_text)
    find(PRODUCT_SORT_DROPDOWN).find('option', text: option_text).select_option
  end
  
  def get_visible_product_names
   
    all(INVENTORY_ITEM_NAME, wait: 5).map(&:text)
  end

  def get_visible_product_prices

    all(INVENTORY_ITEM_PRICE, wait: 5).map { |el| el.text.gsub('$', '').to_f }
  end
  
end