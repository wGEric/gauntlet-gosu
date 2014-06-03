class IntroState < Chingu::GameState
  def initialize(options = {})
    super

    @text = Chingu::Text.create(:text=>"Welcome!", :x=>200, :y=>50, :size=>30)

    self.input = {
      return: PlayerSelectState
    }
  end
end
