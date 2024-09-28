import wollok.game.*

class Corn {

	var property position = null
	var property image = "corn_baby.png"

	method position(sembrador) {
		position = sembrador.position() 
		game.addVisualCharacter( self ) //este self sería siempre una nueva planta
	}

	/*
	por lo que entiendo es que cada clase cuando se va a plantar se referencia a agregarse a sí misma, pero para usarse y agregarse se la va a tener que usar en un "objeto" que se crea con el new Planta() entondes ese self es al objeto y nunca a la clase y por eso funciona?
	*/

	method crecer() {
	  image = "corn_adult.png"
	}

	method serCosechado() {
	  self.validarSerCosechado()
	  game.removeVisual(self)
	}

	method validarSerCosechado() {
	  if( image == "corn_baby.png" ){
		self.error("no estoy listo para ser cocechado")
	  }
	}

	method precio() {
		return 150  
	} 

}

 class Wheat {

	var property position = null
	var property madurez = 0
   
   method position(sembrador) {
		position = sembrador.position() 
		game.addVisualCharacter( self )
	}

	method image() {
	  return "wheat_" + madurez + ".png"
	}

	method crecer() {
		self.madurar()
		self.image()
	}
	
	method madurar() {
	  madurez = if (madurez <= 2) (madurez + 1) else 3 //note to self : era un error matemático no de codigo, tiene que ser mayor o igual a 2 o sino siempre es 3 el resu para no pasarse de la maduración máxima.
	}

	method serCosechado() {
	  self.validarSerCosechado()
	  game.removeVisual(self)
	}

	method validarSerCosechado() {
	  if( madurez < 2 ){
		self.error("no estoy listo para ser cosechado")
	  }
	}

	method precio() {
	  return (madurez - 1) * 100
	}

 }

 class Tomaco {

	var property position = null
	var property vecesRegada = 0
	var property image = "tomaco_baby.png"
   
   method position(sembrador) {
		position = sembrador.position() 
		game.addVisualCharacter( self )
	}
	//no me sale hacer que salga corriendo :(
	method crecer() {
	  vecesRegada = vecesRegada + 1
	  self.madurar()
	  //self.madurarOCorrer()
	}
/*
	method madurarOCorrer() {
	  if(vecesRegada > 1){
		self.correr()
	  } else {
		self.madurar()
	  }
	}

	method correr() { 
	  //self.position()+1.y().max(10)
	}
*/
	method madurar() {
	  image = "tomaco.png" //supongo que tiene que correr cunado ya esta maduro y lo siguen regando porque existe tomaco adulto
	}

	method serCosechado() {
		game.removeVisual(self)
	}

	method precio() {
	  return 80
	}

 }