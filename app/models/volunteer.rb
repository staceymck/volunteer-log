class Volunteer < ApplicationRecord
  belongs_to :user
  has_many :activities
  has_many :roles, through: :activities
end
