class CreateTargets < ActiveRecord::Migration[8.0]
  def change
    create_table :targets do |t|
      t.string :name, null: false
      t.belongs_to :created_by_user, foreign_key: { to_table: :users }
      t.boolean :is_default, default: false, null: false
      t.timestamps
    end
    add_index :targets, :name, unique: true
  end
end
