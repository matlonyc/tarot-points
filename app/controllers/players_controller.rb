class PlayersController < ApplicationController

def new
  @player = Player.new
end

def create
  @game = Game.find(params[:game_id])
  if params[:player]["name"].length > 0
    @player = @game.players.create(params[:player].permit(:name))
    @player.name = @player.name.capitalize
    
    score = PlayerScore.new
    score.score = 0
    @player.player_scores.append score
    @game.number_of_players = @game.number_of_players + 1

    @game.save

    redirect_to new_game_player_path(@game)
  else
    redirect_to game_path(@game)
  end
end

end
