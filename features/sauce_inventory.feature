Feature: Funcionalidad del Inventario
  Como un usuario logueado
  Quiero agregar productos al carrito
  Para poder realizar una compra

  Background:
    Given estoy en la página de inicio de sesión
    And ingreso el nombre de usuario "standard_user"
    And ingreso la contraseña "secret_sauce"
    And hago click en el botón "Login"

  Scenario: Agregar un producto al carrito
    When agrego el producto "Sauce Labs Backpack" al carrito
    Then el icono del carrito muestra "1"

  Scenario: Agregar múltiples productos
    When agrego el producto "Sauce Labs Backpack" al carrito
    And agrego el producto "Sauce Labs Bike Light" al carrito
    Then el icono del carrito muestra "2"
