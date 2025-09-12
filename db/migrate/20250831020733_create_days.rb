class CreateDays < ActiveRecord::Migration[8.0]
  def change
    create_table :days do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.date :occurred_on

      t.timestamps
    end
    add_index :days, [ :user_id, :occurred_on ], unique: true
  end
end
