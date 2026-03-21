require "./scene/start"

module TemplateGameSDL
  class Game < GSDL::Game
    def initialize
      super(title: "TemplateGameSDL", width: 800, height: 600)
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
