module TemplateGameSDL
  class Scene::Start < GameSDL::Scene
    getter start_scene : Symbol?
    getter text : GameSDL::Text

    def initialize
      super(:start)

      @start_scene = nil

      @text = GameSDL::Text.new(
        font: Font.create(32),
        text: "--- X ---",
      )
    end

    def update(frame_time)
      # items.update(frame_time, keys, mouse, joysticks)

      # if items.selected?(keys, mouse, joysticks)
      #   case items.focused_label
      #   when "start"
      #     @start_scene = :main
      #   when "exit"
      #     @exit = true
      #   end
      # elsif keys.just_pressed?(Keys::Escape) || joysticks.just_pressed?(Joysticks::Back)
      #   @exit = true
      # end
    end

    def draw(renderer : SDL::Renderer, window : SDL::Window)
      width, height = window.size

      # centered red rectangle
      renderer.draw_color = SDL::Color[255, 0, 0, 64]
      renderer.fill_rect(width // 4, height // 4, width // 2, height // 2)

      # text
      text.x = (width - text.width) // 2
      text.y = (height - text.height) // 2

      text.draw(renderer, window)
    end
  end
end
