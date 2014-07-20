class Game < ActiveRecord::Base
  has_many :players
  has_many :rounds
  accepts_nested_attributes_for :players
  validates :number_of_players, 
    presence: true#, 
#    value: {minimum: 3, maximum: 5} @todo
end
