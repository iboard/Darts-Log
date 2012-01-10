
class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :upload_id
      t.integer :player_id
      t.string :game
      t.integer :sets
      t.integer :legs
      t.integer :best_winning_leg
      t.float :three_dart_average
      t.integer :highest_checkout
      t.integer :highest_throw
      t.integer :doubles_hit
      t.integer :count_180
      t.integer :count_140
      t.integer :count_100
      t.integer :count_60

      t.timestamps
    end
  end
end
