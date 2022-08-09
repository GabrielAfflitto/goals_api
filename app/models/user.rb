class User < ApplicationRecord
  has_many :goals

  has_secure_password
  validates :email, presence: true
  validates :password, length: { minimum: 8 }, presence: true
  validates :name, presence: true


  # later on, add business logic to the so a user can filter their goals by in progress or completed


end
