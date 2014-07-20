$contracts = { petite: 10,
              pousse: 20,
              garde: 40,
              garde_sans: 80,
              garde_contre: 160 }

def countPoints(startingScoresHash, roundHash)
  points = roundHash[:diff].to_i
  if points >= 0
    points += $contracts[roundHash[:contract].to_sym]
  else
    points -= $contracts[roundHash[:contract].to_sym]
  end

  factor = startingScoresHash.length - 1
  if startingScoresHash.has_key? roundHash[:partner]
    factor -= 2
  end

  finalScoresHash = Hash.new(startingScoresHash)

  startingScoresHash.each do | player_name, score |
    if player_name == roundHash[:lead]
      finalScoresHash[player_name] = score + factor * points
    elsif player_name == roundHash[:partner]
      finalScoresHash[player_name] = score + points
    else
      finalScoresHash[player_name] = score - points
    end
  end

  finalScoresHash
end

class RoundsController < ApplicationController

def new
  @round = Round.new
  @game = Game.find(params[:game_id])
  @players = @game.players
end

def validate_players(round, players_list)
  #valid = players_list.include? round['lead']
  #if valid && round[:partner].length > 0
  #  valid = players_list.include? round[:partner] 
  #end
  valid = true
end

def create
  @game = Game.find(params[:game_id])
  params[:round][:contract] = $contracts.key(params[:round][:contract].to_i)
  params[:round][:lead] = params[:round][:lead].capitalize

  if params[:round].has_key? :partner
    params[:round][:partner] = params[:round][:partner].capitalize
  end
  
  if validate_players(params[:round], @game.players)
    @round = @game.rounds.create(params[:round].permit(:lead, :partner, :diff, :contract))

    currentScores = Hash.new(@game.players.length)
    @game.players.each do |player|
      currentScores[player.name] = player.player_scores.last.score
    end
    updatedScores = countPoints(currentScores,params[:round])

    @game.players.each do |player|
      new_score = PlayerScore.new
      new_score.score = updatedScores[player.name]
      player.player_scores.append new_score
    end

    redirect_to game_path(@game)
  else
    @round = Round.new(params[:round].permit(:lead, :partner, :diff, :contract))
    @round.errors.add('lead','player name invalid')
    render 'new'
  end

end

def index
  @rounds = Round.all
  render text: @rounds.length
end

end
