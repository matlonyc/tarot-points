class RemoveLeadFromRounds < ActiveRecord::Migration
  def change
    remove_column :rounds, :lead, :string
    remove_column :rounds, :partner, :string
  end
end
