class PlayerSelectState < Chingu::GameState
  def initialize(options = {})
    super

    @text = Chingu::Text.create(:text=>"Select character", :x=>200, :y=>50, :size=>30)

    self.input = {
      return: PlayState
    }
  end
end
