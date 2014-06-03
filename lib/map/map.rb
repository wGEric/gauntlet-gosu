module Level
  class Map < Chingu::BasicGameObject
    attr_accessor :tile_width, :tile_height, :width, :height, :tilesets, :objects

    def initialize(file)
      super()
      @tmx = Tmx.load(file)

      @tile_width = @tmx.tilewidth
      @tile_height = @tmx.tileheight

      @width = @tile_width * @tmx.width
      @height = @tile_height * @tmx.height

      @layers = []
      @objects = []
      @tilesets = [nil]

      root_path = Pathname.new($window.root)
      tmx_file_path = File.dirname(file)

      @tmx.tilesets.each do |tileset|
        image_path = Pathname.new(File.expand_path(tileset.image, tmx_file_path))
        @tilesets += Gosu::Image.load_tiles($window, image_path.relative_path_from(root_path).to_s, tileset.tilewidth, tileset.tileheight, true)
      end

      @tmx.layers.each do |layer|
        @layers << Layer.new(layer, self)
      end

      @tmx.objects.each do |map_object|
        object_class = map_object.name.split('::')
        if object_class.size > 1
          next unless Object.const_defined?(object_class[0])
          klass = Object.const_get(object_class[0])
          symbol = object_class[1]
        else
          klass = Object
          symbol = object_class[0]
        end

        if klass.const_defined?(symbol)
          @objects << klass.const_get(symbol).create(map_object.to_h)
        end
      end
    end

    def draw
      super
      @layers.each(&:draw)
    end
  end
end
