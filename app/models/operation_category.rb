class OperationCategory < ApplicationRecord
  has_many :operations, dependent: :destroy
  belongs_to :table
end
