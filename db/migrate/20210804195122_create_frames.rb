class CreateFrames < ActiveRecord::Migration[6.1]
  def change
    create_table :frames, id: :uuid do |t|
      t.uuid :game_id, null: false
      t.integer :number, null: false
      t.integer :score, null: false, default: 0
      t.integer :first_delivery
      t.integer :second_delivery
      t.integer :third_delivery
      t.integer :kind, default: 0
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_foreign_key :frames, :games
    add_index :frames, %i[game_id number], unique: true
  end
end
