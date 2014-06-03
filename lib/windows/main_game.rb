class MainGame < Chingu::Window
  def initialize
    super(640, 480, false)

    self.input = {
      escape: :close
    }

    # push_game_state(IntroState)
    push_game_state(PlayState)
  end
end
