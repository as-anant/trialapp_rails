class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :actioned_at, presence: true
  
  has_many :favorites, foreign_key: 'post_id', dependent: :destroy
  has_many :users, through: :favorites, source: :user
end
