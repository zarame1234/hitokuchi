class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy

  
  validates :body,presence: true, length: { maximum: 50 }
  validates :image,presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(shop_name: content)
    elsif method == 'forward'
      Post.where('shop_name LIKE ? OR body LIKE ?', content + '%', content + '%' )
    elsif method == 'backward'
      Post.where('shop_name LIKE ? OR body LIKE ?', '%' + content, '%' + content )
    else
      Post.where('shop_name LIKE ? OR body LIKE ?', '%' + content + '%', '%' + content + '%' )
    end
  end
end
