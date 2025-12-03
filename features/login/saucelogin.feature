Feature: Login en SauceDemo
  Como un usuario de SauceDemo
  Quiero iniciar sesión
  Para poder ver el catálogo de productos y validar diferentes estados de inicio de sesión

@login_valido @smoke
Scenario Outline: Inicio de sesión y logout exitoso para diferentes usuarios
  Given estoy en la página de inicio de sesión
  When ingreso el nombre de usuario "<username>"
  And ingreso la contraseña "secret_sauce"
  And hago click en el botón "Login"
  Then soy redirigido a la página de productos

  Examples:
    | username                 |
    | standard_user            |
    | problem_user             |
    | performance_glitch_user  |

@login_invalido
Scenario Outline: Login fallido con credenciales incorrectas o usuario bloqueado
  Given estoy en la página de inicio de sesión
  When ingreso el nombre de usuario "<username>"
  And ingreso la contraseña "<password>"
  And hago click en el botón "Login"
  Then veo el mensaje de error de login "<error_message>"

  Examples:
    | username              | password        | error_message                                                            |
    | locked_out_user       | secret_sauce    | Epic sadface: Sorry, this user has been locked out.                      |
    | usuario_inexistente   | secret_sauce    | Epic sadface: Username and password do not match any user in this service|
    | standard_user         | pass_incorrecta | Epic sadface: Username and password do not match any user in this service|
    | invalido              |                 | Epic sadface: Password is required                                       |
    |                       |    invalido     | Epic sadface: Username is required                                       |
    | invalido              |    invalido     | Epic sadface: Username and password do not match any user in this service|