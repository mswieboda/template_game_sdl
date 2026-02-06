require "./scene/start"

module TemplateGameSDL
  class SceneManager < GSDL::SceneManager
    getter start

    def initialize
      super

      @scene = Scene::Start.new
    end
  end
end
