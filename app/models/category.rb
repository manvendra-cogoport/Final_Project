class Category < ApplicationRecord
    has_many :journals
    has_many :articles, through: :journals
end
