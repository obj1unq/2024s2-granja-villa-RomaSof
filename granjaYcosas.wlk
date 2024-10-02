import hector.*
import wollok.game.*

/*De la granja se conocen los cultivos sembrados y si hay alguno en una parcela (posición) específica, como también los cultivos de una parcela dada. Además no deberían estár más en la granja una vez cosechados por Hector.*/
object granja {
  
  const property cultivos =  #{}
  const property construcciones = #{mercado1, mercado2}

  //sembrar:
  method agregarACultivo(granjero, planta) {
    self.validarSembrar(granjero.position())
    planta.position(granjero)
    cultivos.add(planta)
  }
  
	method validarSembrar(position) {
	  if(not self.esEspacioVacio(position)){
		self.error("no se puede sembrar aquí")
	  }
	}

  method esEspacioVacio(position) {
	  return game.getObjectsIn(position).isEmpty()
	}

  //regar:
  method regarAqui(granjero) {
    self.validarRegarAqui(granjero.position())
    self.primeraPlantaEn(granjero.position()).crecer() 
  }
//validar regar aquí debería decirte si hay una planta en la lista con la misma posicion en la que etsá el granjero y además devolderte la plata con otro metodo
  method validarRegarAqui(position) {
	  if (not self.hayPlantasEnParcelaEn(position)){
		self.error("no hay nada para regar")
	  }
	}

  method hayPlantasEnParcelaEn(position) {
    //lista de plantas en esa posicion no empty
    return not self.plantasEnparcelaEn(position).isEmpty()
    
  }

  method plantasEnparcelaEn(position) {
    //filter de la posicion de plantas en esa posicion -> la planta con la misma position
    return cultivos.filter({planta => planta.position() == Position})
    
  }
  //ahora siempre hay una sola la planta en la posicion igual
  method primeraPlantaEn(position) {
    return self.plantasEnparcelaEn(position).head()
  }

  //cosechar
  method eliminarDeCultivos(granjero) {
    self.validareliminarDeCultivos(granjero.position())
    granjero.cosecha().add(self.primeraPlantaEn(granjero.position()))
    self.primeraPlantaEn(granjero.position()).serCosechado()
    cultivos.remove(self.primeraPlantaEn(granjero.position()))
  }

  method validareliminarDeCultivos(position) {
    if (not self.hayPlantasEnParcelaEn(position)){
      self.error("no hay plantas para eliminar")
    }
  }

  //vender
  method hayMercadoAqui(granjero) {
    return not self.mercadosAqui(granjero.position()).isEmpty()
  }

  method mercadosAqui(position) {
    return construcciones.filter({mercado => mercado.position() == position})
  }

  method primerMercadoAqui(granjero) {
    return self.mercadosAqui(granjero.position()).head()
  }

  //dejar aspersor
  method dejarAspersorAqui(granjero) {
    self.validarDejarAspersorAqui(granjero.position())
    Aspersor.position(granjero.position())
  }

  method validarDejarAspersorAqui(position) {
	  if (not self.esEspacioVacio(position)){ 
		self.error("no puedo dejar un aspersor aquí")
	  }
	}

  //aspersor regar
  method validarAspersorRegarPlantas(position) {
    if(not self.hayPlantasEnTodasDireccionesDe(position) ){
      self.error("el aspersor sólo riega cuando hay plantas a su alrededor")
    }
  }
  //entonces no se van a poder poner aspersores en las esquinas.
  method hayPlantasEnTodasDireccionesDe(position) {
    return 
      self.hayPlantasEnParcelaEn(position.up(1))    and
      self.hayPlantasEnParcelaEn(position.right(1)) and
      self.hayPlantasEnParcelaEn(position.down(1))  and
      self.hayPlantasEnParcelaEn(position.left(1))
  }

  method regarPlantas(position) {
    self.validarAspersorRegarPlantas(position)
    self.primeraPlantaEn(position.up(1)).forEach({planta => planta.crecer()})
    self.primeraPlantaEn(position.right(1)).forEach({planta => planta.crecer()})
    self.primeraPlantaEn(position.down(1)).forEach({planta => planta.crecer()})
    self.primeraPlantaEn(position.left(1)).forEach({planta => planta.crecer()})
  }

}

class Aspersor{

    var property position = null
    var property image = "aspersor.png"

    method position(sembrador) {
        position = sembrador.position()
        game.addVisualCharacter( self )
        self.regar()
    }

    method regar() {
      granja.validarAspersorRegarPlantas(self.position())
      game.onTick(1000, self, {self.regarPlantas()})
    }

    method regarPlantas() {
      granja.regarPlantas(self.position())  
    }

}

class Mercado {

  var property position = null
  const property image = "market.png"
  var property cajaMercado = null
  const property mercaderia = #{}

  method recibirMercaderia(vendedor) {
    cajaMercado = self.valorDeCosecha(vendedor) //para que siempre tenga plata para pagarle al que vende
    self.pagar(vendedor)
    mercaderia.addAll(vendedor.cosecha())
  //  self.venderMercaderia() no sé si debería simular la venta
  }

  method pagar(vendedor) {
    cajaMercado = cajaMercado - self.valorDeCosecha(vendedor)
    vendedor.cobrar(self.valorDeCosecha(vendedor))
  }

  method valorDeCosecha(propietario) {
    return  propietario.cosecha().map({planta => planta.precio()}).sum()
  }
/*
  method venderMercaderia() {
    cajaMercado = self.valorDeCosecha(self)
  }
*/
}

const mercado1 = new Mercado( position = game.at(9,9) )
const mercado2 = new Mercado( position = game.at(0,9) )
