module Enemy
  class Base < Chingu::GameObject
    trait :bounding_box, :debug => true
    traits :collision_detection, :collides_with_walls

    def initialize(options)
      super
      self.center = 0

      setup_animations(options)

      update
      cache_bounding_box
    end

    def setup
      super
      @player = Player.all.first
      @speed = 2
    end

    def update
      super
      move
    end

    def move
      @prev_x = @x
      @prev_y = @y

      # left/right movement
      if @x > @player.x
        @x -= @speed
      elsif @x < @player.x
        @x += @speed
      end

      if self.hitting_walls
        @x = @prev_x
      end

      # up/down movement
      if @y > @player.y
        @y -= @speed
      elsif @y < @player.y
        @y += @speed
      end

      if self.hitting_walls
        @y = @prev_y
      end

      update_image if @animations
    end

    private

    def update_image
      x_image_mod = ''
      y_image_mod = ''

      if @x > @prev_x
        x_image_mod = '_right'
      elsif @x < @prev_x
        x_image_mod = '_left'
      end

      if @y > @prev_y
        y_image_mod = '_down'
      elsif @y < @prev_y
        y_image_mod = '_up'
      end

      @animation = @animations["walk#{y_image_mod}#{x_image_mod}".to_sym] if @animations["walk#{y_image_mod}#{x_image_mod}".to_sym]

      @image = @animation.next
    end

    def setup_animation(options = {})
    end
  end
end
