class Tag < ApplicationRecord
  validates :name, presence: true, length: {minimum: 3, maximum: 20}
  validates_uniqueness_of :name
end
