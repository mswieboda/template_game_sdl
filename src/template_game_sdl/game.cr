require "./scene_manager"

module TemplateGameSDL
  WIDTH = 800
  HEIGHT = 600

  class Game < GSDL::Game
    def initialize
      super(title: "TemplateGameSDL", width: WIDTH, height: HEIGHT)
    end

    def init
      super
      @scene_manager = SceneManager.new
    end

    def load_fonts
      GSDL::FontManager.load_default("assets/fonts/PressStart2P.ttf")
    end

    def load_textures
      GSDL::TextureManager.load("player", "./assets/gfx/player.png")
    end
  end
end
