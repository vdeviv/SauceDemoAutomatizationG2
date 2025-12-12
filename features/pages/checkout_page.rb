class CheckoutPage
  include Capybara::DSL
  include RSpec::Matchers


  CAMPO_NOMBRE      = '#first-name'
  CAMPO_APELLIDO    = '#last-name'
  CAMPO_CODIGO_POSTAL = '#postal-code'
  BOTON_CONTINUE    = '#continue'
  ERROR_MENSAJE     = '[data-test="error"]'

  INFO_RESUMEN      = '.summary_info'
  SUBTOTAL_LABEL    = '.summary_subtotal_label'
  IMPUESTO_LABEL    = '.summary_tax_label'
  TOTAL_LABEL       = '.summary_total_label'
  BOTON_FINISH      = '#finish'

  TITULO_PAGINA     = '.title'
  MENSAJE_AGRADECIMIENTO = '.complete-header'
  BOTON_BACK_HOME   = '#back-to-products'
  
 
  def ingresar_datos_envio(datos)
    fill_in CAMPO_NOMBRE, with: datos['nombre']
    fill_in CAMPO_APELLIDO, with: datos['apellido']
    fill_in CAMPO_CODIGO_POSTAL, with: datos['codigo_postal']
  end


  def click_continue
    find(BOTON_CONTINUE).click
  end


  def click_finish
    find(BOTON_FINISH).click
  end


  def click_back_home
    find(BOTON_BACK_HOME).click
  end


  def verificar_info_resumen(texto_esperado)
    expect(page).to have_css(INFO_RESUMEN, text: texto_esperado, wait: 5)
  end


  def verificar_monto(tipo, label, monto_esperado)
    case tipo
    when 'subtotal'
      selector = SUBTOTAL_LABEL
    when 'impuesto'
      selector = IMPUESTO_LABEL
    when 'monto total final'
      selector = TOTAL_LABEL
    else
      raise "Tipo de monto no reconocido: #{tipo}"
    end
    
    expect(page).to have_css(selector, text: label, wait: 5)
    expect(page).to have_css(selector, text: monto_esperado, wait: 5)
  end


  def verificar_encabezado(titulo_esperado)
    expect(find(TITULO_PAGINA).text).to eq(titulo_esperado)
  end


  def verificar_mensaje_agradecimiento(mensaje_esperado)
    expect(find(MENSAJE_AGRADECIMIENTO).text).to eq(mensaje_esperado)
  end


  def verificar_boton_visible(texto_boton)
    expect(page).to have_button(texto_boton)
  end


  def verificar_error_checkout(mensaje_error)
    expect(page).to have_css(ERROR_MENSAJE, text: mensaje_error, wait: 5)
  end
end