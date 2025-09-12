class CreateWorkoutSets < ActiveRecord::Migration[8.0]
  def change
    create_table :workout_sets do |t|
      t.belongs_to :day, null: false, foreign_key: true
      t.belongs_to :exercise, null: false, foreign_key: true
      t.decimal :weight, precision: 5, scale: 2
      t.integer :reps
      t.text :memo
      t.integer :set_number, null: false

      t.timestamps
    end
    add_index :workout_sets, [ :day_id, :exercise_id, :set_number ], unique: true
  end
end
