import cosasGranja.*
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
	  cosecha.add(game.uniqueCollider(self))
	  game.uniqueCollider(self).serCosechado()
	  //game.removeVisual(game.uniqueCollider(self)) es responsabilidad de hector o la planta?
	}

	method validarCosechar() {
	  if (self.esEspacioVacio()){
		self.error("no tengo nada para cosechar")
	  }
	}

	method vender() {
		self.validarVenta()
		game.uniqueCollider(self).recibirMercaderia(self)
	  //ganancias = cosecha.map({planta => planta.precio()}).sum()
	}

	method validarVenta() {
	  if (not cosecha.isEmpty() and game.uniqueCollider(self) == Aspersor ){
		self.error("no tengo nada para vender")
	  }
	}

	method hablar() {
	  game.say(self, "tengo " + ganancias + " monedas y " + cosecha.size() + " plantas para vender ")
	}

	//bonus
	method dejarAspersor(aspersor) {
	  self.validarDejarAspersor()
	  aspersor.position(self)
	}

	method validarDejarAspersor() {
	  if (not self.esEspacioVacio()){
		self.error("no puedo dejar un aspersor aquí")
	  }
	}

}