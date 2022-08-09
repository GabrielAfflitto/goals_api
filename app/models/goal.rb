class Goal < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  enum :status, [:in_progress, :completed]

  # in_progress = 0, completed = 1

  # goal.in_progress scopes Goal.where(status: :in_progress)
  

end
