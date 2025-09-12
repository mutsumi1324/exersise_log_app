class CreateExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :exercises do |t|
      t.belongs_to :body_part, null: false, foreign_key: true
      t.belongs_to :created_by_user, foreign_key: { to_table: :users }
      t.string :name
      t.boolean :is_default, default: false, null: false

      t.timestamps
    end
  end
end
