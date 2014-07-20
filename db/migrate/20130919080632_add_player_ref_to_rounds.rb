class AddPlayerRefToRounds < ActiveRecord::Migration
  def change
    add_reference :rounds, :lead, index: true
  end
end
