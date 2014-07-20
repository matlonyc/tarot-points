class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :lead
      t.string :contract
      t.string :partner
      t.integer :diff
      t.references :game, index: true

      t.timestamps
    end
  end
end
