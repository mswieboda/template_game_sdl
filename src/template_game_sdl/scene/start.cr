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

    def draw(renderer : SDL3::Renderer)
      width = 1920 # Hardcoded, assuming static window size
      height = 1080 # Hardcoded, assuming static window size

      # centered red rectangle
      renderer.draw_color = {255_u8, 0_u8, 0_u8, 64_u8}
      rect = LibSDL3::FRect.new(
        x: (width // 4).to_f32,
        y: (height // 4).to_f32,
        w: (width // 2).to_f32,
        h: (height // 2).to_f32
      )
      renderer.fill_rect(pointerof(rect))

      # text
      text.x = (width - text.width) // 2
      text.y = (height - text.height) // 2

      text.draw(renderer)
    end


  end
end
