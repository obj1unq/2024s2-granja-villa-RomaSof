import granjaYcosas.*
import cultivos.*

import wollok.game.*


object hector {
	var property position = game.at(0,0)
	const property image = "player.png"
	var property ganancias = 0 
	const property cosecha = #{}
	

	method sembrar(planta) {
		self.validarSembrar()
		granja.agregarACultivo(self.position(), planta)
	}

	method validarSembrar() {
	  if(not granja.esEspacioVacio(self.position())){
		self.error("no se puede sembrar aquí")
	  }
	}

	method regar() {
	  self.validarRegar(self.position())
	  granja.regarAqui(self)
	}
	//validar regar debería decirte si hay una planta en la lista con la misma posicion en la que está el granjero
	method validarRegar(parcela) {
	  if (not granja.hayPlantasAqui(parcela)){
		self.error("no hay nada para regar")
	  }
	}

	method cosechar() {
	  self.validareliminarDeCultivos(self.position())
	  cosecha.add(granja.primeraPlantaEn(self.position()))
	  granja.eliminarDeCultivos(self)
	}
	
	method validareliminarDeCultivos(parcela) {
		if (not granja.hayPlantasAqui(parcela)){
		self.error("no hay plantas para eliminar")
		}
	}

	method vender(mercado) {
		mercado.recibirMercaderia(self)
		cosecha.clear()
	}

	method venderAqui() {
	  self.validarVentaAqui()
	  self.vender(granja.primerMercadoAqui(self.position()))
	}

	method validarVentaAqui() {
	  if (not granja.hayMercadosAqui(self.position())){
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
		self.validarDejarAspersorAqui(self.position())
		granja.dejarAspersorAqui(self.position(), aspersor)
	}

	method validarDejarAspersorAqui(_position) {
	  if (not granja.esEspacioVacio(_position)){ 
		self.error("no puedo dejar un aspersor aquí")
	  }
	}

}