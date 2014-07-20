class AddLeadToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :lead, :string
    add_column :rounds, :partner, :string
  end
end
