class Article < ApplicationRecord

  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, length: {maximum: 20}
  validates :body, presence: true, length: {maximum: 140}

end
