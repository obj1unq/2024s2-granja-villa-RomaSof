import hector.*
import wollok.game.*

class Aspersor{

    var property position = null

    method position(sembrador) {
        position = sembrador.position()
        game.addVisualCharacter( self )
    }

    method regar() {
      self.regarAl("up")
      self.regarAl("right")
      self.regarAl("down")
      self.regarAl("left")

    }

    method regarAl(direction) {
      game.getObjectsIn(self.positionLimitrofe(direction)).regar()
    }
    //game.getObjectsIn(self.positionLimitrofe("right")).regar()

    method positionLimitrofe(direction) {
      return self.position().x().direction(1)
    }

}

/*//game.getObjectsIn(game.right(1))
      const derecha = self.position().x().right(1)
* Returns a new Position n steps right from this one.
      //self.position().withX(self.position().x() + 1)
      //position(self.position().x() + 1, self.position().y())
      //position(self.position().x() + 1, self.position().y())
      game.getObjectsIn( derecha )
      //self.position().x()+1, self.position().y()
*/


