import hector.*
import cultivos.*

import wollok.game.*

/*
  De la granja se conocen los cultivos sembrados y si hay alguno en una parcela (posición) específica, como también los cultivos de una parcela dada. Además no deberían estár más en la granja una vez cosechados por Hector.
*/

object granja {
  
  const property cultivos =  #{}
  const property construcciones = #{mercado1, mercado2} 
  const property cosasJardineria = #{}

  //sembrar:
  method agregarACultivo(position, planta) {
    planta.position(position)
    cultivos.add(planta)
  }

  method esEspacioVacio(position) { 
    return not self.hayPlantasAqui(position) and not self.hayMercadosAqui(position) //and not self.hayCosasDeJardineriaAqui(position) 
	}

  //regar:
  method regarAqui(position) {
    self.primeraPlantaEn(position).crecer() 
  }

  method hayPlantasAqui(position) {
    return not self.plantasEnparcelaEn(position).isEmpty()    
  }

  method plantasEnparcelaEn(position) {
    return cultivos.filter({planta => planta.position().equals(position)})
  }
  //ahora siempre hay una sola la planta en la posicion igual "primera" solo devuelve una cualquiera del ser
  method primeraPlantaEn(position) {
    return self.plantasEnparcelaEn(position).head()
  }

  //cosechar
  method eliminarDeCultivos(position) { 
    const planta = self.primeraPlantaEn(position)
    cultivos.remove(planta)
    planta.serCosechado()
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

  //aspersor
  method dejarAspersorAqui(position, aspersor) {
    aspersor.position(position)
    construcciones.add(aspersor)
  }

  method haycosasJardineriaAqui(position) {
    return not self.cosasJardineriaAqui(position).isEmpty()
  }

  method cosasJardineriaAqui(position) {
    return cosasJardineria.filter({cosa => cosa.position().equals(position)})
  } 

  method plantasEnPerimetroDeAspersor(position) {
    return  (
              self.plantasEnparcelaEn(position.up(1))     +
              self.plantasEnparcelaEn(position.right(1))  +
              self.plantasEnparcelaEn(position.down(1))   +
              self.plantasEnparcelaEn(position.left(1))
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
      game.onTick(1000, self, {self.regarPlantas()})
    }

    method regarPlantas() {
      const plantasRegables = granja.plantasEnPerimetroDeAspersor(position)
      plantasRegables.forEach({planta => planta.regar()})
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
