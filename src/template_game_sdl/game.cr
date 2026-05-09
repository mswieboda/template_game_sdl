require "./scene/start"

module TemplateGameSDL
  class Game < GSDL::Game
    def initialize
      super(
        title: "TemplateGameSDL",
        width: 1024,
        height: 768,
        # logical_width: 1024,
        # logical_height: 768,
        # maximized: true,
        high_pixel_density: true
      )
    end

    def init
      GSDL::Game.push(Scene::Start.new)
    end

    def load_default_font
      "fonts/PressStart2P.ttf"
    end

    def load_textures
      [{"player", "gfx/player.png"}]
    end
  end
end
