class Table < ApplicationRecord
  has_many :operations, dependent: :destroy
  has_many :operation_categories, dependent: :destroy
  belongs_to :user
end
