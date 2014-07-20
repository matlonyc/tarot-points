class AddMorePlayerRefToRounds < ActiveRecord::Migration
  def change
    add_reference :rounds, :lead, index: true
    add_reference :rounds, :partner, index: true
  end
end
