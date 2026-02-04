module TemplateGameSDL
  class Font < GameSDL::Font
    def self.default_file
      File.join("assets", "PressStart2P.ttf")
    end
  end
end
