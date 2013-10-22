class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.decimal :amount
      t.integer :user_id

      t.timestamps
    end
    add_index :contributions, [:user_id, :created_at]
  end
end
