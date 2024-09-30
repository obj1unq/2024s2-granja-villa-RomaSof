import hector.*
import wollok.game.*

class Aspersor{

    var property position = null
    var property image = "aspersor.png"

    method position(sembrador) {
        position = sembrador.position()
        game.addVisualCharacter( self )
        self.regar()
    }

    method regar() {
      //self.validarRegar() ¿cómo evitar que riegue cosas que no son plantas?
      game.onTick(1000, self, {self.regarPlantasCercanas()})
    }
/*
    method validarRegar() { 
      if(not self.hayPlantasCercanar()){
        self.error("faltan plantas para regar")
      }
    }

    method hayPlantasCercanar() { con un regar si es planta?
      return not (
        game.getObjectsIn(position.up(1)).isEmpty()     and
        game.getObjectsIn(position.right(1)).isEmpty()  and
        game.getObjectsIn(position.down(1)).isEmpty()   and
        game.getObjectsIn(position.left(1)).isEmpty() 
      )
    }
*/
    method regarPlantasCercanas() {
      game.getObjectsIn(position.up(1)).forEach({planta => planta.crecer()})
      game.getObjectsIn(position.right(1)).forEach({planta => planta.crecer()})
      game.getObjectsIn(position.down(1)).forEach({planta => planta.crecer()})
      game.getObjectsIn(position.left(1)).forEach({planta => planta.crecer()})
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
