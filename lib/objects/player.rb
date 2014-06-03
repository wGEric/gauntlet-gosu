class Player < Chingu::GameObject
  trait :bounding_box, :debug => false
  traits :collision_detection, :collides_with_walls

  def initialize(options)
    super
    self.input = [:holding_left, :holding_right, :holding_up, :holding_down]
    self.center = 0
    self.zorder = 9999

    setup_animations(options)

    @speed = 3

    @prev_x = @x
    @prev_y = @y

    @vel_x = 0
    @vel_y = 0

    update
    cache_bounding_box
  end

  def holding_left
    @vel_x = -1 * @speed
  end

  def holding_right
    @vel_x = @speed
  end

  def holding_up
    @vel_y = -1 * @speed
  end

  def holding_down
    @vel_y = @speed
  end

  def update
    super
    move
  end

  def move
    if @vel_x != 0 || @vel_y != 0
      @prev_x = @x
      @prev_y = @y

      # move one axis at a time so if going diagonal it will continue to go at least one direction
      @x += @vel_x
      if self.hitting_walls
        @x = @prev_x
      end

      @y += @vel_y
      if self.hitting_walls
        @y = @prev_y
      end

      update_image

      @vel_x = 0
      @vel_y = 0
    end
  end

  private

  def setup_animations(options)
    @animations = Chingu::Animation.new(file: "entities_32x32.png")
    @animations[:walk_up] = @animations.new_from_frames([0, 8, 0, 16])
    @animations[:walk_up_right] = @animations.new_from_frames([1, 9, 1, 16])
    @animations[:walk_right] = @animations.new_from_frames([2, 10, 2, 18])
    @animations[:walk_down_right] = @animations.new_from_frames([3, 11, 3, 19])
    @animations[:walk_down] = @animations.new_from_frames([4, 12, 4, 20])
    @animations[:walk_down_left] = @animations.new_from_frames([5, 13, 5, 21])
    @animations[:walk_left] = @animations.new_from_frames([6, 14, 6, 22])
    @animations[:walk_up_left] = @animations.new_from_frames([7, 15, 7, 23])

    if options[:properties] && options[:properties]["animation"] && @animations[options[:properties]["animation"].to_sym]
      @animation = @animations[options[:properties]["animation"].to_sym]
    else
      @animation = @animations[:walk_up]
    end

    @image = @animation.image
  end

  def update_image
    x_image_mod = ''
    y_image_mod = ''

    if @vel_x > 0
      x_image_mod = '_right'
    elsif @vel_x < 0
      x_image_mod = '_left'
    end

    if @vel_y > 0
      y_image_mod = '_down'
    elsif @vel_y < 0
      y_image_mod = '_up'
    end

    @animation = @animations["walk#{y_image_mod}#{x_image_mod}".to_sym] if @animations["walk#{y_image_mod}#{x_image_mod}".to_sym]

    @image = @animation.next
  end

end
