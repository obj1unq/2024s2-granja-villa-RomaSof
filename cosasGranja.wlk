import hector.*
import wollok.game.*

class Aspersor{

    var property position = null

    method position(sembrador) {
        position = sembrador.position()
        game.addVisualCharacter( new Aspersor() )
    }

    method regar() {
        game.onTick(1000, self, {self.regarPlantasCercanas()})
    }

    method regarPlantasCercanas() {
      game.getObjectsIn(position.up(1)).regar()
      game.getObjectsIn(position.right(1)).regar()
      game.getObjectsIn(position.down(1)).regar()
      game.getObjectsIn(position.left(1)).regar()     
    }
/*
game.getObjectsIn( game.at(self.position().x() + 1, self.position().y()) ).regar()    
game.getObjectsIn( game.at(self.position().x() - 1, self.position().y()) ).regar()
game.getObjectsIn( game.at(self.position().x(), self.position().y() + 1) ).regar()
game.getObjectsIn( game.at(self.position().x(), self.position().y() - 1) ).regar()
*/
}

class Mercado {

  var property position = null
  const property image = "market.png"
  var property cantidadMonedas = null
  var property mercaderia = #{}

}


/*
para mercado
   * Returns the unique object that is in same position of given object.
   */  
  //method uniqueCollider(visual) = self.colliders(visual).uniqueElement()
