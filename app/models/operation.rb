class Operation < ApplicationRecord
  belongs_to :table
  belongs_to :user
  belongs_to :operation_category
end
