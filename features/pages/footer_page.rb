class FooterPage
  include Capybara::DSL
  include RSpec::Matchers
  

  FOOTER_CONTAINER = '.footer' 

  COPYRIGHT_TEXT   = '.footer_copy'
  

  SOCIAL_TWITTER   = '.social_twitter a'
  SOCIAL_FACEBOOK  = '.social_facebook a'
  SOCIAL_LINKEDIN  = '.social_linkedin a'


  ICON_TWITTER     = '.social_twitter'
  ICON_FACEBOOK    = '.social_facebook'
  ICON_LINKEDIN    = '.social_linkedin'


  def scroll_to_footer
    page.execute_script "window.scrollTo(0, document.body.scrollHeight)"
  end


  def click_social_icon(red_social)
    selector = case red_social
               when 'Twitter' then SOCIAL_TWITTER
               when 'Facebook' then SOCIAL_FACEBOOK
               when 'LinkedIn' then SOCIAL_LINKEDIN
               else raise "Red social no reconocida: #{red_social}"
               end
    find(selector).click
  end

  def social_icon_is_visible?(red_social)
    selector = case red_social
               when 'Twitter' then ICON_TWITTER
               when 'Facebook' then ICON_FACEBOOK
               when 'LinkedIn' then ICON_LINKEDIN
               else return false
               end
    has_css?(selector, visible: true)
  end

  def verify_copyright_text(texto_esperado)
    footer_text = find(COPYRIGHT_TEXT, wait: 5).text
    footer_text.include?(texto_esperado)
  end
  

  def validate_new_window_url(url_esperada)
    # Aquí es donde fallaba 'expect'
    expect(page.driver.browser.window_handles.length).to be > 1
    
    window_original = page.driver.browser.window_handles.first
    ventana_nueva = page.driver.browser.window_handles.last
    page.driver.browser.switch_to.window(ventana_nueva)
    
    url_match = case 
                when url_esperada.include?("facebook") then current_url.include?("facebook.com")
                when url_esperada.include?("linkedin") then current_url.include?("linkedin.com")
                when url_esperada.include?("x.com")    then current_url.include?("x.com/saucelabs")
                else current_url.include?(url_esperada)
                end
    
    page.driver.browser.close
    page.driver.browser.switch_to.window(window_original)
    
    return url_match
  end

  
end