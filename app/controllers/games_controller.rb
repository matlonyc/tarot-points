class GamesController < ApplicationController

def index
  @games = Game.all
end

def show
  @game = Game.find(params[:id])
  if params.has_key? 'delete_round'
    round_number = params['delete_round'].to_i
    if round_number > 0 
      @game.players.each do | player |
        score = player.player_scores[round_number]
        score.destroy
      end 
    end
  redirect_to game_path(@game)
  end
end

def new
  @game = Game.new
end

def create
  @game = Game.new(game_params)
  @game.date = Date.today
  @game.number_of_players = 0
  if @game.save
    redirect_to new_game_player_path(@game)
  else
    render text: @game.errors.first
  end
end

def destroy
  @game = Game.find(params[:id])
  @game.destroy
  redirect_to games_path
end

private
  def game_params
    params.require(:game).permit(:location)
  end

end
