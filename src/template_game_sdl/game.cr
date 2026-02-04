require "./scene_manager"

module TemplateGameSDL
  class Game < GameSDL::Game
    def initialize
      super(title: "Game SDL Template")

      @scene_manager = TemplateGameSDL::SceneManager.new
    end
  end
end
