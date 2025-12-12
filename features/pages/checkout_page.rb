# pages/checkout_page.rb
class CheckoutPage
  include Capybara::DSL
  include RSpec::Matchers

  # Selectores de la página 'Your Information' (Paso 1)
  # Usamos data-test o id para ser robustos.
  CAMPO_NOMBRE      = '#first-name'
  CAMPO_APELLIDO    = '#last-name'
  CAMPO_CODIGO_POSTAL = '#postal-code'
  BOTON_CONTINUE    = '#continue'
  ERROR_MENSAJE     = '[data-test="error"]'

  # Selectores de la página 'Overview' (Paso 2)
  INFO_RESUMEN      = '.summary_info'
  SUBTOTAL_LABEL    = '.summary_subtotal_label'
  IMPUESTO_LABEL    = '.summary_tax_label'
  TOTAL_LABEL       = '.summary_total_label'
  BOTON_FINISH      = '#finish'

  # Selectores de la página 'Complete' (Paso 3)
  TITULO_PAGINA     = '.title'
  MENSAJE_AGRADECIMIENTO = '.complete-header'
  BOTON_BACK_HOME   = '#back-to-products'
  
  # --- Acciones y Métodos ---

  # Acción para ingresar los datos de envío
  def ingresar_datos_envio(datos)
    fill_in CAMPO_NOMBRE, with: datos['nombre']
    fill_in CAMPO_APELLIDO, with: datos['apellido']
    fill_in CAMPO_CODIGO_POSTAL, with: datos['codigo_postal']
  end

  # Acción para hacer click en Continuar
  def click_continue
    find(BOTON_CONTINUE).click
  end

  # Acción para hacer click en Finalizar
  def click_finish
    find(BOTON_FINISH).click
  end

  # Acción para hacer click en Volver a Inicio
  def click_back_home
    find(BOTON_BACK_HOME).click
  end

  # Validación de información de pago/envío
  def verificar_info_resumen(texto_esperado)
    expect(page).to have_css(INFO_RESUMEN, text: texto_esperado, wait: 5)
  end

  # Validación de desglose financiero (Subtotal, Impuesto, Total)
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

  # Validación del encabezado (Título de la página)
  def verificar_encabezado(titulo_esperado)
    expect(find(TITULO_PAGINA).text).to eq(titulo_esperado)
  end

  # Validación del mensaje de agradecimiento
  def verificar_mensaje_agradecimiento(mensaje_esperado)
    expect(find(MENSAJE_AGRADECIMIENTO).text).to eq(mensaje_esperado)
  end

  # Validación del botón visible
  def verificar_boton_visible(texto_boton)
    expect(page).to have_button(texto_boton)
  end

  # Validación de mensaje de error
  def verificar_error_checkout(mensaje_error)
    expect(page).to have_css(ERROR_MENSAJE, text: mensaje_error, wait: 5)
  end
end