class Product < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :product_orders, dependent: :destroy

  belongs_to :category

  enum classify: [:food, :drink]
  mount_uploader :picture_link, PictureUploader

  validates :name, presence: true, length: {in: 6..50}
  validates :content, presence: true, length: {minimum: 50}
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0.5}
  validates :quantity, presence: true, numericality: {only_integer: true}

  class << self
    def filter classify, category, sorted_by
      filter = Array.new
      filter << ["classify = #{classify}"] if classify.present?
      filter << ["category_id = #{category}"] if category.present?
      products = where(filter.join " AND ").order sorted_by
    end
  end  
end
