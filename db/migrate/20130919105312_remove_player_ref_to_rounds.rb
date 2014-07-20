class RemovePlayerRefToRounds < ActiveRecord::Migration
  def change
    remove_reference :rounds, :lead, index: true
    remove_reference :rounds, :partner, index: true
  end
end
