require 'squib'

Squib::Deck.new do
	background color: :white
	text str: 'Hello, world!'
	save_png prefix: 'hello_'
end