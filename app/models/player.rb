class Player < ActiveRecord::Base
  belongs_to :game
  has_many :player_scores
end
