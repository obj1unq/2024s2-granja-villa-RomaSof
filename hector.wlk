import granjaYcosas.*
import wollok.game.*


object hector {
	var property position = game.center()
	const property image = "player.png"
	var property ganancias = 0 
	const property cosecha = #{}
	

	method sembrar(planta) {
	  granja.agregarACultivo(self, planta)
	}

	method regar() {
	  granja.regarAqui(self)
	}

	method cosechar() {
	  granja.eliminarDeCultivos(self)
	}

	method vender(mercado) {
		mercado.recibirMercaderia(self)
		cosecha.clear()
	}

	method venderAqui() {
	  self.validarVentaAqui()
	  self.vender(granja.primerMercadoAqui(self))
	}

	method validarVentaAqui() {
	  if (not granja.hayMercadoAqui(self)){
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
	  granja.dejarAspersorAqui(self)
	}

}