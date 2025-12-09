class NavMenuPage
  include Capybara::DSL

  MENU_BUTTON = '#react-burger-menu-btn'
  MENU_CONTAINER = '#menu_button_container'
  CLOSE_MENU_BUTTON = '#react-burger-cross-btn'
  MENU_ITEMS = '.bm-item-list a'
  
  LOGOUT_LINK = '#logout_sidebar_link'
  ABOUT_LINK = '#about_sidebar_link'
  RESET_APP_STATE_LINK = '#reset_sidebar_link'
  

  def open_menu
    find(MENU_BUTTON).click

    wait_for_menu_to_open
  end

  def close_menu_visible?
    has_selector?(CLOSE_MENU_BUTTON, visible: true)
  end

  def click_menu_item(item_name)
    case item_name
    when "Logout"
        find(LOGOUT_LINK).click
    when "About"
        find(ABOUT_LINK).click
    when "Reset App State"
        find(RESET_APP_STATE_LINK).click
    else

        find(MENU_ITEMS, text: item_name).click
    end
  end
  
  def get_menu_items_text

    all(MENU_ITEMS).map(&:text)
  end

  private

  def wait_for_menu_to_open
     has_css?(MENU_CONTAINER, visible: true, wait: 5)
  end

end