require 'squib'
require 'httparty'
require 'game_icons'
require_relative 'version'

url = File.read('gsheets_url.txt')
response = HTTParty.get(url)
raise response unless response.success?
File.open('data/sse.csv', 'w+') { |f| f.write response.body }

data = Squib.csv file: 'data/sse.csv'

File.open('data/sse.txt', 'w+') {|f| f.write(data.to_pretty_text)}

Squib::Deck.new(cards: data.nrows) do
  background color: "#f5ebe0"

  use_layout file: 'layouts/deck.yml'

  text str: data.name, layout: :name
  text str: data.description, layout: :description #, hint: :red

	svg layout: :weapon,
	    data: GameIcons.get('crossbow').recolor(fg: '333', bg: 'fff0').string

  icons = data.icon.map do |str|
    GameIcons.get(str)&.recolor(fg: '333', bg: 'fff0').string
  end
  svg layout: :icon, data: icons

  png layout: :art,
      file: data.name.map {|n| "#{n.downcase}.png"}

  png layout: :grit

  rect layout: :whole_card_gradient

  showcase trim: 37.5, trim_radius: 37.5

  save_sheet prefix: 'sheet_',
              columns: 2, rows: 2,
              margin: 75, gap: 5, trim: 37

  save_png prefix: 'figure_', range: 0,
       trim_radius: 37.5, trim: 37.5, shadow_radius: 15


  # build(:proofs) do
    # safe_zone
    # cut_zone
  # end

  save format: :png

end
