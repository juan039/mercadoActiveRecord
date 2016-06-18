class CreateItems < ActiveRecord::Migration
  def change
  	create_table :items do |t|
  		t.belongs_to :usuario, index:true
  		t.string :nombre
  		t.integer :precio
  	end
  end
end
