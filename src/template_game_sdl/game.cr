require "./scene_manager"

module TemplateGameSDL
  class Game < GSDL::Game
    def initialize
      super(title: "TemplateGameSDL", width: 800, height: 600)
    end

    def init
      @scene_manager = SceneManager.new
    end

    def load_fonts
      [{"default", "fonts/PressStart2P.ttf", 16_f32}]
    end

    def load_textures
      [{"player", "gfx/player.png"}]
    end
  end
end
