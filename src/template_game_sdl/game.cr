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

    def load_textures
      GSDL::FontManager.load(GSDL::Font::DEFAULT_FONT_PATH, GSDL::Font::DEFAULT_FONT_SIZE)
      GSDL::TextureManager.load("player", "./assets/gfx/player.png")
    end
  end
end
