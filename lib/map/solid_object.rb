module Level
  class SolidObject < Chingu::GameObject
    trait :bounding_box, :debug => false

    def setup
      self.center = 0
      self.alpha = 0
    end
  end
end
