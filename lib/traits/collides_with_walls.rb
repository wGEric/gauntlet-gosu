module Chingu
  module Traits
    module CollidesWithWalls
      def setup_trait(options)
        super
        @walls = Chingu::GameObjectMap.new(game_objects: Level::SolidObject.all, grid: [32, 32], debug: false)
      end

      def hitting_walls
        @walls.at(self.bb.left, self.bb.top) || @walls.at(self.bb.left, self.bb.bottom) || @walls.at(self.bb.right, self.bb.top) || @walls.at(self.bb.right, self.bb.bottom)
      end
    end
  end
end
