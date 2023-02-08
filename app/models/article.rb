class Article < ApplicationRecord
    has_many :journals
    has_many :categories, through: :journals

    belongs_to :user
    has_many :likes, dependent: :destroy
end
