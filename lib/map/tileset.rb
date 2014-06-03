module Level
  class Tileset
    def initialize(tmx, base_path)
      @tmx = tmx

      image_path = Pathname.new(File.expand_path(@tmx.image, base_path))
      root_path = Pathname.new($window.root)

      @images = Gosu::Image.load_tiles($window, image_path.relative_path_from(root_path).to_s, @tmx.tilewidth, @tmx.tileheight, true)
    end

    def [](index)
      @images[index]
    end
  end
end
