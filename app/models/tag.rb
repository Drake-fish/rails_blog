class Tag < ApplicationRecord
  has_many :article_tags
  has_many :posts, through: :article_tags
  validates :name, presence: true, length: {minimum: 3, maximum: 20}
  validates_uniqueness_of :name
end
