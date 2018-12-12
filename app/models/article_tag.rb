class ArticleTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
end
