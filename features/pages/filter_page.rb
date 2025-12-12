class FilterPage
  include Capybara::DSL

  # --- Selectores de Filtro y Productos ---
  PRODUCT_SORT_DROPDOWN = '.product_sort_container'
  # INVENTORY_CONTAINER = '#inventory_container' <-- Lo dejamos como comentario, ya no se usará con 'find'
  
  # Selectores de ítems
  INVENTORY_ITEM_NAME   = '.inventory_item_name'
  INVENTORY_ITEM_PRICE  = '.inventory_item_price'
  
  # --- Acciones (Filtro) ---
  
  def select_sort_option(option_text)
    find(PRODUCT_SORT_DROPDOWN).find('option', text: option_text).select_option
  end

  # --- Métodos de Obtención de Datos (Lectura de la UI) ---
  
  # Captura los nombres de los productos visibles en la UI
  def get_visible_product_names
    # CORREGIDO: Usamos all para encontrar todos los elementos de nombre.
    # Capybara espera automáticamente la carga de los elementos dentro de 'all'.
    # Si el elemento tarda en aparecer, puedes ajustar Capybara.default_max_wait_time
    all(INVENTORY_ITEM_NAME, wait: 5).map(&:text)
  end

  # Captura los precios de los productos visibles en la UI y los convierte a float
  def get_visible_product_prices
    # CORREGIDO: Eliminamos el 'find' ambiguo.
    all(INVENTORY_ITEM_PRICE, wait: 5).map { |el| el.text.gsub('$', '').to_f }
  end
  
end