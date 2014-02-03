class AddAttachmentImagePreviewToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :image_preview
    end
  end

  def self.down
    drop_attached_file :items, :image_preview
  end
end
