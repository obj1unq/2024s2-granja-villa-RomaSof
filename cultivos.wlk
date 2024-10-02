import hector.*
import granjaYcosas.*

import wollok.game.*

class Corn {

	var property position = null
	var property image = "corn_baby.png"

	method position(sembrador) {
		position = sembrador.position() 
		game.addVisualCharacter( self ) //este self sería siempre una nueva planta
	}

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
	  madurez = if (madurez <= 2) (madurez + 1) else 3
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

	method crecer() {
	  vecesRegada = vecesRegada + 1
	  image = "tomaco.png"
	  self.madurar()
	}

	method madurar() {
	  position = game.at(self.position().x(), self.position().y()+1)
	}

	method serCosechado() {
		game.removeVisual(self)
	}

	method precio() {
	  return 80
	}

 }