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
		granja.agregarACultivo(position, planta)
	}

	method validarSembrar() {
	  if(not granja.esEspacioVacio(position)){
		self.error("no se puede sembrar aquí")
	  }
	}

	method regar() {
	  self.validarRegar(position)
	  granja.regarAqui(position)
	}

	method validarRegar(_position) {
	  if (not granja.hayPlantasAqui(_position)){
		self.error("no hay nada para regar")
	  }
	}

	method cosechar() {
	  self.validareCosecharEn(position)
	  const planta = granja.primeraPlantaEn(position)
	  cosecha.add(planta)
	  granja.eliminarDeCultivos(planta)
	}
	
	method validareCosecharEn(_position) {
		if (not granja.sePuedeCosecharAqui(_position)){
		self.error("no hay plantas para eliminar")
		}
	}

	method vender(mercado) {
		mercado.recibirMercaderia(self)
		cosecha.clear()
	}

	method venderAqui() {
	  self.validarVentaAqui()
	  self.vender(granja.primerMercadoAqui(position))
	}

	method validarVentaAqui() {
	  if (not granja.hayMercadosAqui(position)){
		self.error("solo puedo vender en un mercado")
	  }
	}

	method cobrar(monto) {
	  ganancias = ganancias + monto
	}

	method hablar() {
	  game.say(self, "tengo " + ganancias + " monedas y " + cosecha.size() + " plantas para vender ")
	} 

	//bonus
	method dejarAspersor(aspersor) {
		self.validarDejarAspersorAqui(position)
		granja.dejarAspersorAqui(position, aspersor)
	}

	method validarDejarAspersorAqui(_position) {
	  if (not granja.esEspacioVacio(_position)){ 
		self.error("no puedo dejar un aspersor aquí")
	  }
	}

}