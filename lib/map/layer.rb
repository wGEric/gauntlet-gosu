module Level
  class Layer < Chingu::BasicGameObject
    traits :viewport

    def initialize(tmx, map)
      super()
      @tmx = tmx
      @map = map

      row = 0
      @tmx.data.each_with_index do |tileset_id, index|
        row += 1 if index > 0 && index % @tmx.width == 0

        next if tileset_id == 0

        x = (index - row * @tmx.width) * @map.tile_width
        y = row * @map.tile_height

        properties = {
          image: @map.tilesets[tileset_id],
          x: x,
          y: y
        }

        tile = @tmx.name == 'collision' ? SolidObject.create(properties) : Chingu::GameObject.create(properties)
        # the center in the line above doesn't work. Bug in Chingu?
        tile.center = 0
      end
    end
  end
end
