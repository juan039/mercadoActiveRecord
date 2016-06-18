class CreateHeroes < ActiveRecord::Migration
  def change
  	create_table :heroes do |t|
  		t.string :nombre
  		t.integer :nivel_de_poder
  	end
  end
end
