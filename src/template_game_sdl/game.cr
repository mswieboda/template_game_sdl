require "./scene_manager"

module TemplateGameSDL
  class Game < GSDL::Game
    def initialize
      super(title: "TemplateGameSDL", width: 800, height: 600)
    end

    def init
      super

      @scene_manager = SceneManager.new
    end

    def load_fonts
      GSDL::FontManager.load_default("fonts/PressStart2P.ttf")
    end

    def load_textures
      GSDL::TextureManager.load("player", "gfx/player.png")
    end
  end
end
