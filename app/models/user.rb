class User < ApplicationRecord
  has_many :goals

  has_secure_password
  validates :email, presence: true
  validates :password, length: { minimum: 8 }, presence: true
  validates :name, presence: true


end
