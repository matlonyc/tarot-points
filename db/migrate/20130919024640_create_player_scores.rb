class CreatePlayerScores < ActiveRecord::Migration
  def change
    create_table :player_scores do |t|
      t.integer :score
      t.references :player, index: true

      t.timestamps
    end
  end
end
