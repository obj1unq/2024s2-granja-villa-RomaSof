import wollok.game.*


object hector {
	var property position = game.center()
	const property image = "player.png"
	var property ganancias = 0 
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
	  self.validarCosechar()
	  game.uniqueCollider(self).serCosechado()
	  cosecha.add(game.uniqueCollider(self))
	  game.removeVisual(game.uniqueCollider(self))
	}

	method validarCosechar() {
	  if (self.esEspacioVacio()){
		self.error("no tengo nada para cosechar")
	  }
	}

	method vender() {
		self.validarVenta()
	  ganancias = cosecha.map({planta => planta.precio()}).sum()
	}

	method validarVenta() {
	  if (cosecha.isEmpty()){
		self.error("no tengo nada para vender")
	  }
	}

	method text() {
	  "tengo" + ganancias "monedas y" + cosecha.size() + "plantas para vender"  
	}

}