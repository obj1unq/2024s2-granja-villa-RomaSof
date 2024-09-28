import wollok.game.*
import hector.*

class Corn {

	var property position = null

	method position(sembrador) {
		position = sembrador.position() 
		game.addVisualCharacter( self ) //este self sería siempre una nueva planta
	}

	/*
	por lo que entiendo es que cada clase cuando se va a plantar se referencia a agregarse a sí misma, pero para usarse y agregarse se la va a tener que usar en un "objeto" que se crea con el new Planta() entondes ese self es al objeto y nunca a la clase y por eso funciona?
	*/

	method image() {
		return "corn_baby.png"
	}

	method crecer() {
	  return "corn_adult.png"
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
	  //return "wheat_0.png"
	}

	method crecer() {
		self.madurar()
		self.image()
	}
	
	method madurar() {
	  madurez = if (madurez <= 2) (madurez + 1) else 3 //note to self : era un error matemático no de codigo, tiene que ser mayor o igual a 2 o sino siempre es 3 el resu para no pasarse de la maduración máxima.
	}

 }

 class Tomaco {

	var property position = null
	var property vecesRegada = 0
   
   method position(sembrador) {
		position = sembrador.position() 
		game.addVisualCharacter( self )
	}

	method image() {
	  return "tomaco_baby.png"
	}
	//se mueve como planta mutante? D:
	method crecer() {
	  //return "tomaco.png"
	  vecesRegada = vecesRegada + 1
	  self.madurarOCorrer()
	}

	method madurarOCorrer() {
	  if(vecesRegada > 1){
		self.correr()
	  } else {
		self.madurar()
	  }
	}

	method correr() {
	  //se mueve sin importar si haya una planta o no?
	}

	method madurar() {
	  return "tomaco.png"
	}

 }