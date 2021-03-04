class Role < ApplicationRecord
  belongs_to :user
  has_many :activities
  has_many :volunteers, through: :activities
end
