class User < ApplicationRecord
  has_secure_password
  has_secure_token

  has_many :operations, dependent: :destroy
  has_many :tables, dependent: :destroy

  def invalidate_token
    update(token: nil)
  end
end