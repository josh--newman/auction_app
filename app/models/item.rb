class Item < ActiveRecord::Base
  
  default_scope -> { order('created_at DESC') }
  belongs_to :category
  belongs_to :user
  has_many :bids, dependent: :destroy

  has_attached_file :image_preview, 
                    :styles => { :medium => "256x256#", :thumb => "180x180#" },
                    :default_url => "missing.png"
  validates_attachment_content_type :image_preview, 
  :content_type => ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  validates :name, presence: true, length: { maximum: 50 }
  validates :category_id, presence: true
  validates :user_id,     presence: true
  validates :finish_time, presence: true

  def self.search(name, category_id)
    if !category_id.empty?
      # search with category_id
      where("name || description LIKE ? AND category_id = ?", 
            "%#{name}%", "#{category_id}")
    else
      # there is no category_id
      where("name || description LIKE ?",
            "%#{name}%")
    end
  end

end
