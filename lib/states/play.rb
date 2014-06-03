class PlayState < Chingu::GameState
  trait :viewport

  def setup
    @map = Level::Map.new('maps/level0.tmx')
    @player = Player.all.first

    self.viewport.game_area = [0, 0, @map.width, @map.height]
  end

  def update
    self.viewport.center_around(@player)
    super
    # puts self.viewport
  end

  def draw
    @map.draw
    super
  end
end
