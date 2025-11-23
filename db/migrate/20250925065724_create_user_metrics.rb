class CreateUserMetrics < ActiveRecord::Migration[8.0]
  def change
    create_table :user_metrics do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :height
      t.decimal :body_weight, precision: 5, scale: 2

      t.timestamps
    end
  end
end
