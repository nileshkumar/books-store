class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :author, presence: true
  validates :publication_date, presence: true
  validates :title, uniqueness: true
end
