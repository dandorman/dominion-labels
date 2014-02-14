require "prawn"
require "yaml"

cards = YAML.load_file "cards.yml"
cards << {
  "title" => "Chapel",
  "expansion" => "Base",
  "type" => "Action",
  "cost" => 2,
}

margins = {
  top_margin: 36,
  right_margin: 18,
  bottom_margin: 36,
  left_margin: 18
}

Prawn::Document.generate "dominion.pdf", margins do
  define_grid columns: 4, rows: 20, column_gutter: 18
  # grid.show_all
  cards.each_with_index do |card, i|
    next unless i + 1 == cards.length
    grid(*i.divmod(20).reverse).bounding_box do
      bounding_box [10, bounds.height - 5], width: bounds.width - 20, height: bounds.height - 10 do
        font("Helvetica", size: 14, style: :bold) do
          text_box card["title"].upcase, at: [0, bounds.height], height: 16, width: bounds.width, overflow: :shrink_to_fit
        end
        font("Helvetica", size: 8) do
          text_box [card["expansion"], card["type"], card["cost"]].join(" / "), at: [0, 10], height: 10, width: bounds.width, overflow: :shrink_to_fit
        end
      end
    end
  end
end
