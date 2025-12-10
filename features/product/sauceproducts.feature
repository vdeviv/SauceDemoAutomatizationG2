Feature: Visualización de Productos

  Background: Login exitoso
    Given estoy en la página de inicio de sesión
    When ingreso el nombre de usuario "standard_user"
    And ingreso la contraseña "secret_sauce"
    And hago click en el botón "Login"
    Then soy redirigido a la página de productos

  @products_validation
  Scenario: Validar que se muestren los 6 productos correctos en el inventario
    # Esta validación mata dos pájaros de un tiro:
    # 1. Valida que sean exactamente 6 (por el tamaño de la lista).
    # 2. Valida "cuales" son (comparando los textos).
    Then deberia ver exactamente estos productos en la lista:
      | Sauce Labs Backpack               |
      | Sauce Labs Bike Light             |
      | Sauce Labs Bolt T-Shirt           |
      | Sauce Labs Fleece Jacket          |
      | Sauce Labs Onesie                 |
      | Test.allTheThings() T-Shirt (Red) |