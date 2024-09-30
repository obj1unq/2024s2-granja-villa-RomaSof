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

	method regar(planta) {
	  planta.crecer()
	}

	method regarAqui() {
		self.validarRegarAqui()
		self.regar(game.uniqueCollider(self))
	}

	method validarRegarAqui() {
	  if (self.esEspacioVacio()){
		self.error("no tengo nada para regar")
	  }
	}

	method cosechar(planta) {
	  cosecha.add(planta)
	  planta.serCosechado()
	}

	method cosecharAqui() {
		self.validarCosecharAqui()
		self.cosechar(game.uniqueCollider(self))
	}

	method validarCosecharAqui() {
	  if (self.esEspacioVacio()){
		self.error("no tengo nada para cosechar")
	  }
	}

	method vender(mercado) {
		mercado.recibirMercaderia(self)
		cosecha.clear()
	}

	method venderAqui() {
	  self.validarVentaAqui()
	  self.vender(game.uniqueCollider(self))
	}

	method validarVentaAqui() {
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