require "sinatra"

go_fish_path = File.expand_path('../../go_fish', __FILE__)
$LOAD_PATH.unshift(go_fish_path) unless $LOAD_PATH.include?(go_fish_path)
require 'game'
require 'player'
require 'card'
require 'deck'
require 'turn_result'
require 'players_view'

get '/' do
  erb :index
end

post '/game_setup' do
  player_count = params[:player_count].to_i
  @@game = Game.new(player_count)
  redirect to('/play_turn')
end

get '/play_turn' do
  other_players = @@game.players - [@@game.active_player]
  erb :play_turn, locals: { current_player: @@game.active_player, other_players: other_players }
end