class Article < ApplicationRecord

  validates :title, presence: true, length: {maximum: 140}, uniqueness: true
  validates :body, presence: true, length: {maximum: 500}

end
