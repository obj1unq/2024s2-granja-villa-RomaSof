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

    method regar() { //1000
        game.onTick(999, self, {self.regarPlantasCercanas()})
    }

    method regarPlantasCercanas() {
      //const positionNow = self.position()
      game.getObjectsIn(position.up(1)).forEach({planta => planta.crecer()})
      game.getObjectsIn(position.right(1)).forEach({planta => planta.crecer()})
      game.getObjectsIn(position.down(1)).forEach({planta => planta.crecer()})
      game.getObjectsIn(position.left(1)).forEach({planta => planta.crecer()})
    }
/*
game.getObjectsIn( game.at(self.position().x() + 1, self.position().y()) ).crecer()
game.getObjectsIn( game.at(self.position().x() - 1, self.position().y()) ).crecer()
game.getObjectsIn( game.at(self.position().x(), self.position().y() + 1) ).crecer()
game.getObjectsIn( game.at(self.position().x(), self.position().y() - 1) ).crecer()
*/
/*
game.getObjectsIn(position.up(1)).crecer()
game.getObjectsIn(position.right(1)).crecer()
game.getObjectsIn(position.down(1)).crecer()
game.getObjectsIn(position.left(1)).crecer()
*/
}

class Mercado {

  var property position = null
  const property image = "market.png"
  var property cajaMercado = null
  const property mercaderia = #{}

  method recibirMercaderia(vendedor) {
    cajaMercado = self.valorDeCosecha(vendedor)
    self.pagar(vendedor)
    mercaderia.add(vendedor.cosecha())
    vendedor.mercaderia(#{})
    self.venderMercaderia()
  }

  method pagar(vendedor) {
    cajaMercado = cajaMercado - self.valorDeCosecha(vendedor)
    vendedor.ganancias(self.valorDeCosecha(vendedor))
  }

  method valorDeCosecha(propietario) {
    return propietario.cosecha().map({planta => planta.precio()}).sum()
  }

  method venderMercaderia() {
    cajaMercado = self.valorDeCosecha(self)

  }

}
