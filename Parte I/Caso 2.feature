Feature: Proceso de compras a través del carrito desde la selección del producto
Como Falabella Servicios Financieros
Quiero comprobar las funcionalidades criticas del carrito de compras
Para evitar inconvenientes con el comprador en el sitio de compras

Scenario: Compra con usuario Registrado con stock de productos
	Given cliente logueado tiene sus productos seleccionados 
	And todos los productos tienen stock
	When selecciona boton Pagar	
	Then envía a la pantalla de ingreso del comprador, medio de pago y direccion de despacho para continuar con la compra

Scenario: Compra sin proceso de login
  Given cliente no logueado tiene sus productos seleccionados
  When selecciona boton Pagar
  Then Web Solicita opcionalmente registrarse, sino, envía a la pantalla de ingreso del comprador, medio de pago y direccion de despacho para continuar con la compra

Scenario: Seleccion de producto sin stock
  When selecciona producto <productosinstock>
  Then Debe tener boton Agregar al Carrito deshabilitado e indicar "Producto sin stock"

Scenario: Seleccion de producto con stock
  When selecciona producto <id>
  Then Debe tener boton Agregar al carrito habilitado y mostrar la cantidad de stock disponible
      And se agrega el/los productos al carrito de compras

Scenario: Pagar productos con datos de tarjeta de credito no validos
  When clickear en Pagar 
  And ingresar datos de tarjeta de credito no validos en la seccion medio de pago
  Then No debe permitir realizar la compra, debe aparecer el pop up "Tarjeta de credito ingresada, no es valida"

Scenario: Pagar productos con datos de tarjeta de credito sin saldo
  Given tarjeta de credito sin saldo
  When clickear en Pagar
  Then No debe permitir realizar la compra, debe aparecer el pop up "Tarjeta de credito ingresada no tiene el saldo suficiente"

Scenario: Pagar productos con datos de tarjeta de credito bloqueada
 Given tarjeta de credito bloqueada
  When clickear en Pagar
  Then No debe permitir realizar la compra, debe aparecer el pop up "Tarjeta de credito bloqueada"
  
Scenario: Despacho invalido
 Given medio de pago aceptado
  When ingresar código postal inválido
  Then No debe permitir realizar la compra, debe aparecer el pop up "Despacho inválido, favor ingrese código postal"
    
Scenario: Campos requeridos sin llenar
	Given campos sin rellenar de Datos del Cliente, Despacho, Medios de Pago
    When clickear en Pagar
  	Then No debe permitir realizar la compra, debe aparecer el pop up "Datos requeridos" y se deben marcar los campos faltantes en rojo.
    
Scenario: Pagar carrito de compras vacio
	Given Ningun producto agregado al carrito de Compras
    When clickear en Pagar
	Then No debe permitir realizar la compra, debe aparecer inhabilitado el boton pagar
    
Scenario: Pagar carrito de compras con stock y garantia extendida
	Given campos rellenados de Datos del Cliente, Despacho, Medios de Pago
	And productos agregados al carrito de compras
	When seleccionar opcion Garantia Extendida y Pagar es posible pagar el total de los productos y el valor de la garantia extendida

Examples:
|	productoconstock| id    | stock |
|	zapatillas	|	1	|	10  |

Examples:
|	productosinstock| id    | stock |
|	poleras	|	2	|	1	|	0
