class Volunteer < ApplicationRecord
  belongs_to :user
  has_many :activities
  has_many :roles, through: :activities
  enum age_group: {over_eighteen: 0, over_twenty_one: 1}
  enum background_check_status: {incomplete: 0, approved: 1, flagged: 2}
end
