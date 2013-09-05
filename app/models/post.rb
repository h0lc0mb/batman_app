class Post < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  has_many :responses, dependent: :destroy
  #accepts_nested_attributes_for :responses, allow_destroy: true

  validates :content, presence: true, length: { maximum: 2500 }
  validates :user_id, presence: true

  default_scope order: 'posts.created_at DESC'
end