require "crsfml"
require "./helpers/display.cr"

module Mirrors
  class StartDisplay < Display
    @listener : Listener
    @texture : SF::RenderTexture

    @new_display : Display?

    private def add_start_buttons
      font = SF::Font.from_file("resources/FiraCode.ttf")

      play_text = SF::Text.new("Play", font)
      play_text.centre({0, 0}, {200, 40})
      play_text.fill_color = SF::Color.new(100, 100, 100)

      play_texture = SF::RenderTexture.new(200, 40)
      play_texture.clear
      play_texture.draw(play_text)
      play_texture.display

      play_button = Button.new(play_texture.texture, ->() {
        grid = LevelReader.parse("resources/level1.json")
        @new_display = LevelDisplay.new(grid)

        return
      })

      play_button.on_hover do
        play_text.fill_color = SF::Color::White
        play_texture.clear
        play_texture.draw(play_text)
        play_texture.display
      end

      play_button.exit_hover do
        play_text.fill_color = SF::Color.new(100, 100, 100)
        play_texture.clear
        play_texture.draw(play_text)
        play_texture.display
      end

      play_button.position = {300, 280}
      @listener.add_item(play_button, true)
    end

    def initialize
      super

      add_start_buttons
    end

    private def draw_logo
    end

    def draw
      draw_listener

      draw_logo
    end
  end
end