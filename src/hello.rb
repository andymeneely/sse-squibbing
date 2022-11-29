require 'squib'

Squib::Deck.new(cards: 2) do
	background color: :white

	text str: ['Hello', 'world!']
	save_png prefix: 'hello_'
end