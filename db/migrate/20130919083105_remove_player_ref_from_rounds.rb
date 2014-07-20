class RemovePlayerRefFromRounds < ActiveRecord::Migration
  def change
    remove_reference :rounds, :lead, index: true
  end
end
