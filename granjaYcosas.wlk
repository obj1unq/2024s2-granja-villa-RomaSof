import hector.*
import cultivos.*
import wollok.game.*

object granja {
  
  const property cultivos =  #{}
  const property construcciones = #{mercado1, mercado2} 
  const property cosasJardineria = #{}

  //sembrar:
  method agregarACultivo(position, planta) {
    planta.position(position)
    game.addVisual( planta )
    cultivos.add(planta)
  }

  method esEspacioVacio(position) { 
    return not self.hayPlantasAqui(position) and not self.hayMercadosAqui(position) and not self.hayCosasDeJardineriaAqui(position) 
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
    // == position
  }
  //ahora siempre hay una sola la planta en la posicion igual "primera" solo devuelve una cualquiera del ser
  method primeraPlantaEn(position) {
    return self.plantasEnparcelaEn(position).asList().head()
  }

  //cosechar
  method eliminarDeCultivos(planta) { 
    cultivos.remove(planta)
    planta.serCosechado()
  }

  method sePuedeCosecharAqui(position) {
    return self.hayPlantasAqui(position) and self.primeraPlantaEn(position).puedeSerCosechado()
  }


  //vender
  method hayMercadosAqui(position) {
    return construcciones.any({mercado => mercado.position().equals(position)})
  }

  method primerMercadoAqui(position) {
    return construcciones.find({mercado => mercado.position().equals(position)})
  }

  //aspersor
  method dejarAspersorAqui(position, aspersor) {
    aspersor.position(position)
    cosasJardineria.add(aspersor)
  }

  method hayCosasDeJardineriaAqui(position) {
    return not self.cosasJardineriaAqui(position).isEmpty()
  }

  method cosasJardineriaAqui(position) {
    return cosasJardineria.filter({cosa => cosa.position().equals(position)})
  } 

  method plantasEnPerimetroDeAspersor(position) {
    const distanciasARegar= [position.up(1), position.right(1), position.down(1), position.left(1)]
  return cultivos.filter({cultivo => distanciasARegar.contains(cultivo.position())})
  }

}

class Aspersor{

    var property position = null
    var property image = "aspersor.png"

    method position(_position) {
        position = _position
        game.addVisual( self )
        self.regar()
    }

    method regar() {
      game.onTick(1000, self, {self.regarPlantas()})
    }

    method regarPlantas() {
      const plantasRegables = granja.plantasEnPerimetroDeAspersor(position)
      plantasRegables.forEach({planta => planta.crecer()})
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
  }

  method pagar(vendedor) {
    cajaMercado = cajaMercado - self.valorDeCosecha(vendedor)
    vendedor.cobrar(self.valorDeCosecha(vendedor))
  }

  method valorDeCosecha(propietario) {
    return  propietario.cosecha().map({planta => planta.precio()}).sum()
  }

}
