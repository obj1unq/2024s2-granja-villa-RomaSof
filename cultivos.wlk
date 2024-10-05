import hector.*
import granjaYcosas.*
import wollok.game.*

class Corn {

	var property position = null
	var property image = "corn_baby.png"

	method crecer() {
	  image = "corn_adult.png"
	}

	method serCosechado() {
	  game.removeVisual(self)
	}

	method puedeSerCosechado() {
		return image == "corn_adult.png"
	}

	method precio() {
		return 150  
	} 

}

 class Wheat {

	var property position = null
	var property madurez = 0

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
	  game.removeVisual(self)
	}

	method puedeSerCosechado() {
		return madurez > 2
	}

	method precio() {
	  return (madurez - 1) * 100
	}

 }

 class Tomaco {

	var property position = null
	var property vecesRegada = 0
	var property image = "tomaco_baby.png"

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

	method puedeSerCosechado() { 
		return true 
	} 

	method precio() {
	  return 80
	}

 }