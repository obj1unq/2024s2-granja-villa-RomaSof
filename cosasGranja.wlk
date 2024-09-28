import hector.*
import wollok.game.*

class Aspersor{

    var property position = null

    method position(sembrador) {
        position = sembrador.position()
        game.addVisualCharacter( self )
    }

    method regar() {
      //game.getObjectsIn(game.right(1))
      const derecha = self.position().x().right(1)

      //self.position().withX(self.position().x() + 1)
      //position(self.position().x() + 1, self.position().y())
      //position(self.position().x() + 1, self.position().y())
      game.getObjectsIn( derecha )
      //self.position().x()+1, self.position().y()

    }

    method positionLimitrofe() {
      
    }

}


