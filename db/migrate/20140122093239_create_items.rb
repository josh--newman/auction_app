class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, :null => false
      t.text :description
      t.string :vendor
      t.decimal :starting_price, 
                :precision => 8, :scale => 2,
                :null => false, :default => 0.99

      t.references :category, :null => false

      t.timestamps
    end
  end
end
