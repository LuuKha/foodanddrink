class Suggest < ActiveRecord::Base
  belongs_to :user

  scope :desc_created_at, -> {order created_at: :desc}
  validates :content, presence: true, length: {maximum: 140}
end
