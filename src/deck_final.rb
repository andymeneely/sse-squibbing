require 'squib'
require 'httparty'
require 'game_icons'
require_relative 'version'

# Note: run this code by running "rake" at the command line
# To see full list of options, run "rake -T"

# Download from Google Docs:

url = File.read('gsheets_url.txt')
response = HTTParty.get(url)
raise response unless response.success?
File.open('data/sse.csv', 'w+') { |f| f.write response.body }

data = Squib.csv file: 'data/sse.csv'

File.open('data/sse.txt', 'w+') {|f| f.write(data.to_pretty_text)}

Squib::Deck.new(cards: data.nrows) do
  background color: "#a8dadc"
  use_layout file: 'layouts/deck.yml'

  text str: data.name, layout: :name
  text str: data.description, layout: :ATK



  # text str: data.atk.map { |s| "#{s} ATK" }, layout: :ATK
  # text str: data.def.map { |s| "#{s} DEF" }, layout: :DEF

  svg file: 'example.svg'

	svg layout: :health,
	    data: GameIcons.get('glass-heart').recolor(fg: '333', bg: 'fff0').string

  text str: MySquibGame::VERSION, layout: :version

  # build(:proofs) do
    safe_zone
    cut_zone
  # end

  save format: :png

end
