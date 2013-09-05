class ChangeContentFormatInResponses < ActiveRecord::Migration
  def up
  	change_column :responses, :content, :text
  end

  def down
  	change_column :responses, :content, :string
  end
end
