class AddFinishTimeToItems < ActiveRecord::Migration
  def change
    add_column :items, :finish_time, :datetime
  end
end
