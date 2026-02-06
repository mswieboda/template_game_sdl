module TemplateGameSDL
  class Scene::Start < GSDL::Scene
    @sprite : GSDL::AnimatedSprite
    @text : GSDL::Text

    def initialize
      super(:start)

      @sprite = GSDL::AnimatedSprite.new("player", 128, 128)
      @sprite.center(WIDTH, HEIGHT)
      @sprite.add("fire", (0..3).to_a, 12)
      @sprite.play("fire")

      color = GSDL::Color.new(r: 0, g: 255, b: 0, a: 255)
      @text = GSDL::Text.new(text: "hello world!", color: color)

      # Center the text
      text_width = @text.width
      text_height = @text.height
      @text.x = (WIDTH - text_width) // 2
      @text.y = (HEIGHT - text_height) // 2
    end

    def update(dt : Float32)
      @sprite.update(dt)
    end

    def draw(renderer : SDL3::Renderer)
      @sprite.draw(renderer)
      @text.draw(renderer)
    end
  end
end
