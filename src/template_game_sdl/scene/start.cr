module TemplateGameSDL
  class Scene::Start < GSDL::Scene
    @sprite : GSDL::AnimatedSprite

    def initialize
      super(:start)

      @sprite = GSDL::AnimatedSprite.new("player", 128, 128)
      @sprite.center(WIDTH, HEIGHT)
      @sprite.add("fire", (0..3).to_a, 12)
      @sprite.play("fire")
    end

    def update(dt : Float32)
      @sprite.update(dt)
    end

    def draw(renderer : SDL3::Renderer)
      @sprite.draw(renderer)
    end
  end
end
