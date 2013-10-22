class ChangeAmountColumnToFloat < ActiveRecord::Migration
  def up
  	change_column :contributions, :amount, :float
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
