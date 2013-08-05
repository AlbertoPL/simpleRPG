class AddTwoColumnsToCharacters < ActiveRecord::Migration
  def change
  	add_column :characters, :maxhp, :integer, :default => 50
  	add_column :characters, :enemy_id, :integer, :default => nil
  end
end
