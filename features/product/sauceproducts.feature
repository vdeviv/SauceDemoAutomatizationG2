Feature: Visualización de Productos

  Background: Login exitoso
    Given estoy en la página de inicio de sesión
    When ingreso el nombre de usuario "standard_user"
    And ingreso la contraseña "secret_sauce"
    And hago click en el botón "Login"
    Then soy redirigido a la página de productos

  @products_count
  Scenario: Validar que se muestren exactamente 6 productos
    Then debo ver un total de 6 productos en la página