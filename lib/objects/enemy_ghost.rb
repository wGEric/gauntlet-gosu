module Enemy
  class Ghost < Base

    private

    def setup_animations(options)
      @animations = Chingu::Animation.new(file: "entities_32x32.png")
      @animations[:walk_up] = @animations.new_from_frames([140, 148, 140, 156])
      @animations[:walk_up_right] = @animations.new_from_frames([141, 149, 141, 157])
      @animations[:walk_right] = @animations.new_from_frames([142, 150, 142, 158])
      @animations[:walk_down_right] = @animations.new_from_frames([143, 151, 143, 159])
      @animations[:walk_down] = @animations.new_from_frames([144, 152, 144, 160])
      @animations[:walk_down_left] = @animations.new_from_frames([145, 153, 145, 161])
      @animations[:walk_left] = @animations.new_from_frames([146, 154, 146, 162])
      @animations[:walk_up_left] = @animations.new_from_frames([147, 155, 147, 163])
      @animations[:explode] = @animations.new_from_frames([328, 329, 330, 331, 332, 333])

      if options[:properties] && options[:properties]["animation"] && @animations[options[:properties]["animation"].to_sym]
        @animation = @animations[options[:properties]["animation"].to_sym]
      else
        @animation = @animations[:walk_up]
      end

      @image = @animation.image
    end
  end
end
