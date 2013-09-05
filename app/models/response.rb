class Response < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :post

  #accepts_nested_attributes_for :post

  validates :content, presence: :true, length: { maximum: 2500 }
  validates :user_id, presence: true
  validates :post_id, presence: :true
end