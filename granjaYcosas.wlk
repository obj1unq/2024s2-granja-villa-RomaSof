import hector.*
import cultivos.*

import wollok.game.*

/*
  De la granja se conocen los cultivos sembrados y si hay alguno en una parcela (posición) específica, como también los cultivos de una parcela dada. Además no deberían estár más en la granja una vez cosechados por Hector.
*/

//por alguna razón no se comiteo la última versión todavía. 

object granja {
  
  const property cultivos =  #{}
  const property construcciones = #{mercado1, mercado2}

  //sembrar:
  method agregarACultivo(position, planta) {
    planta.position(position)
    cultivos.add(planta)
  }

  method esEspacioVacio(position) { //solo anda con colliders igual
    return not self.hayPlantasAqui(position) and not self.hayMercadosAqui(position)
      //return cultivos.filter({cultivo => cultivo.position() == granjero.position()}).isEmpty() and 
      //construcciones.filter({cons => cons.position() == granjero.position()}).isEmpty()
	}

  //regar:
  method regarAqui(position) {
    self.primeraPlantaEn(position).crecer() 
  }

  method hayPlantasAqui(position) {
    //lista de plantas en esa posicion no empty
    return not self.plantasEnparcelaEn(position).isEmpty()    
  }

  method plantasEnparcelaEn(position) {
    //filter de la posicion de plantas en esa posicion -> la planta con la misma position
    return cultivos.filter({planta => planta.position().equals(position)})
  }
  //ahora siempre hay una sola la planta en la posicion igual "primera" solo devuelve una cualquiera del ser
  method primeraPlantaEn(position) {
    return self.plantasEnparcelaEn(position).head()
  }

  //cosechar
  method eliminarDeCultivos(position) {
    cultivos.remove(self.primeraPlantaEn(position))
    self.primeraPlantaEn(position).serCosechado()
  }


  //vender
  method hayMercadosAqui(position) {
    return not self.mercadosAqui(position).isEmpty()
  }

  method mercadosAqui(position) {
    return construcciones.filter({mercado => mercado.position().equals(position)})
  }

  method primerMercadoAqui(position) {
    return self.mercadosAqui(position).head()
  }

  //dejar aspersor
  method dejarAspersorAqui(position, aspersor) {
    aspersor.position(position)
    construcciones.add(aspersor)
  }

  //aspersor 
  
  //entonces no se van a poder poner aspersores en las esquinas.
  method hayPlantasEnTodasDireccionesDe(position) {
    return  (
              self.hayPlantasAqui(position.up(1))    and
              self.hayPlantasAqui(position.right(1)) and
              self.hayPlantasAqui(position.down(1))  and
              self.hayPlantasAqui(position.left(1))
            )
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
      self.validarAspersorRegarPlantas(self.position())
      game.onTick(1000, self, {self.regarPlantas()})
    }

    method validarAspersorRegarPlantas(parcela) {
      if(not granja.hayPlantasEnTodasDireccionesDe(parcela) ){
        self.error("el aspersor sólo riega cuando hay plantas a su alrededor")
      }
    }

    method regarPlantas() {
      self.validarAspersorRegarPlantas(position)
      granja.primeraPlantaEn(position.up(1)).forEach({planta => planta.crecer()})
      granja.primeraPlantaEn(position.right(1)).forEach({planta => planta.crecer()})
      granja.primeraPlantaEn(position.down(1)).forEach({planta => planta.crecer()})
      granja.primeraPlantaEn(position.left(1)).forEach({planta => planta.crecer()})
    }

}

const mercado1 = new Mercado( position = game.at(9,9) )
const mercado2 = new Mercado( position = game.at(0,9) )

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
