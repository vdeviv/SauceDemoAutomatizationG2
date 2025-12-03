@footer
Feature: Footer y Redes Sociales
  Como usuario en la tienda
  Quiero acceder a las redes sociales y ver la información legal
  Para estar conectado con la marca Sauce Labs

  Background:
    Given estoy en la página de inicio de sesión
    And ingreso el nombre de usuario "standard_user"
    And ingreso la contraseña "secret_sauce"
    And hago click en el botón "Login"
    And hago scroll hasta el final de la página

  Scenario: Verificar elementos del footer
    Then debería ver los iconos de redes sociales:
      | Twitter   |
      | Facebook  |
      | LinkedIn  |
    And debería ver el texto de copyright "© 2025 Sauce Labs. All Rights Reserved. Terms of Service | Privacy Policy"

  Scenario Outline: Los enlaces sociales abren la URL correcta en nueva pestaña
    When hago click en el icono de "<red_social>"
    Then se debería abrir una nueva pestaña con la URL "<url_esperada>"

    Examples:
      | red_social | url_esperada                        |
      | Twitter    | https://x.com/saucelabs             |
      | Facebook   | https://www.facebook.com/saucelabs  |
      | LinkedIn   | https://www.linkedin.com/company/sauce-labs |