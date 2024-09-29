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
	  if(not self.esEspacioVacio()){
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
	}

	method validarCosechar() {
	  if (self.esEspacioVacio()){
		self.error("no tengo nada para cosechar")
	  }
	}

	method vender() {
		self.validarVenta()
		game.uniqueCollider(self).recibirMercaderia(self)
	}

	method validarVenta() {
	  if (self.esEspacioVacio() and game.uniqueCollider(self).className() != "cosasGranja.Mercado"){
		self.error("solo puedo vender en un mercado")
	  }
	}

	method cobrar(monto) {
	  ganancias = ganancias + monto
	}

	method hablar() {
	  game.say(self, "tengo " + ganancias + " monedas y " + cosecha.size() + " plantas para vender ")
	} //a veces el hablar no anda y no sé por qué

	//bonus
	method dejarAspersor(aspersor) {
	  self.validarDejarAspersor()
	  aspersor.position(self)
	}

	method validarDejarAspersor() {
	  if (not self.esEspacioVacio()){ //podría agregarle más requisitos para agregar el aspersor?
		self.error("no puedo dejar un aspersor aquí")
	  }
	}

}