class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :amount
      t.references :user, index: true
      t.references :item, index: true

      t.timestamps
    end
  end
end
