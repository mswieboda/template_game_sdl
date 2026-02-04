require "game_sdl"

require "./template_game_sdl/game"
require "./template_game_sdl/font"

module TemplateGameSDL
  # alias Keys = GSF::Keys
  # alias Mouse = GSF::Mouse
  # alias Joysticks = GSF::Joysticks
  # alias Screen = GSF::Screen
  # alias Timer = GSF::Timer

  Game.new.run
end
