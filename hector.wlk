import wollok.game.*

object hector {
	var property position = game.center()
	const property image = "player.png"
	var property ganacias = 0 
	const property cosecha = #{}

	method sembrar(planta) {
	  self.validarSembrar()
	  planta.position(self)
	}

	method validarSembrar() {
	  if( not self.esEspacioVacio() ){
		self.error("no se puede sembrar aquí")
	  }
	}

	method esEspacioVacio() {
	  return game.colliders(self).isEmpty()
	}

	method regar() {
	  self.validarRegar()
	  game.uniqueCollider(self).crecer()
	}

	method validarRegar() {
	  if (self.esEspacioVacio()){
		self.error("no tengo nada para regar")
	  }
	}

	method cosechar() {
	  //el objeto que tenga en frente
	}

	method vender() {
	  
	}

}