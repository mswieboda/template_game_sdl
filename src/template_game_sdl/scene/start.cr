module TemplateGameSDL
  class Scene::Start < GSDL::Scene
    @text : GSDL::TextBeta
    @sprite : GSDL::AnimatedSprite

    def initialize
      transition_in = GSDL::FadeTransition.new(
        direction: GSDL::TransitionDirection::In,
        duration: 0.75_f32,
        started: true
      )
      transition_out = GSDL::FadeTransition.new(
        direction: GSDL::TransitionDirection::Out,
        duration: 0.5_f32
      )

      super(:start, transition_in: transition_in, transition_out: transition_out)

      @sprite = GSDL::AnimatedSprite.new("player", width: 128, height: 128, origin: {0.5_f32, 0.5_f32})
      @sprite.center(width: GSDL::Game.width, height: GSDL::Game.height + 300)
      @sprite.add("fire", (0..3).to_a, 12)
      @sprite.play("fire")

      @entities << @sprite

      hud = GSDL::HUD.new

      color = GSDL::Color.new(g: 255, a: 255)
      hud << GSDL::HUDText.new(
        text: "TemplateGameSDL!",
        color: color,
        anchor: GSDL::Anchor::TopCenter,
        offset_y: 128,
        origin: {0.5_f32, 0.5_f32}
      )

      # TextBeta testing
      font_path = "./assets/fonts/PressStart2P.ttf"
      font_atlas = GSDL::FontAtlas.new(font_path, 16)
      @text = GSDL::TextBeta.new(
        font_atlas: font_atlas,
        text: "jumping quickly over lazy dogs\nis good exercise!\nbatty1 batty2 batty3",
        x: Game.width // 2,
        y: Game.height // 2,
        origin: {0.5_f32, 0.5_f32},
        h_align: GSDL::HorizontalAlign::Center,
        v_align: GSDL::VerticalAlign::Center,
        line_spacing: 2,
        # typing: GSDL::TextBeta::Typing::Word,
        shadow: {2, 2},
        shadow_color: GSDL::Color::Magenta,
        # outline: 2,
        # rotation: 30,
        character_spacing: 2,
        width: 300,
        height: 300,
      )

      self.hud = hud

      # tween sprite to start
      tween = @sprite.tween
      tween.add_sequence([
        {
          :duration => 0.8,
          :rotation => 0.0,
          :scale => {2.0_f32, 2.0_f32},
          :easing => :ease_in_out
        },
        {
          :duration => 1.5,
          :rotation => -180.0,
          :scale => {0.75_f32, 0.75_f32},
        },
        {
          :duration => 0.5,
          :rotation => 270.0,
          :scale => {0.1_f32, 0.1_f32},
          :easing => :ease_in
        },
        {
          :duration => 1.0,
          :rotation => 0.0,
          :scale => {1_f32, 1_f32},
          :easing => :ease_out
        }
      ])
      tween.start(loop: true)
    end

    def update(dt : Float32)
      super(dt)

      if GSDL::Keys.just_pressed?(GSDL::Keys::Escape)
        transition_out.start
      end

      if GSDL::Keys.just_pressed?(GSDL::Keys::Tab)
        # active_object.tweens.clear
        @sprite.flash
      end
    end

    # NOTE: no `draw_camera_view` since entities and HUD are drawn automatically

    def draw_screen_overlay(draw : GSDL::Draw)
      super(draw)

      box_bg = GSDL::Box.new(
        x: @text.x,
        y: @text.y,
        width: @text.width,
        height: @text.height,
        origin: @text.origin,
        scale: @text.scale,
        rotation: @text.rotation,
        color: GSDL::Color.gray(64),
        z_index: @text.z_index - 1,
      )

      circle_xy = GSDL::Circle.new(
        x: @text.x,
        y: @text.y,
        origin: {0.5_f32, 0.5_f32},
        radius: 16,
        color: GSDL::Color::Magenta,
        z_index: @text.z_index_max + 1,
      )

      box_bg.draw(draw)
      @text.draw(draw)
      circle_xy.draw(draw)
    end
  end
end
