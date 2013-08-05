class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|	
	  t.integer :hp, :default => 50
      t.integer :mindamage, :default => 0
      t.integer :maxdamage, :default => 10
      t.integer :gold, :default => 0
      t.integer :level, :default => 1
      t.integer :exp, :default => 0
      t.integer :hpperlevel, :default => 10
      t.integer :expperkill, :default => 20
      t.timestamps
    end
  end
end
