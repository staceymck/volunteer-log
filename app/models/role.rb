class Role < ApplicationRecord
  belongs_to :user
  has_many :activities
  has_many :volunteers, through: :activities
  enum age_requirement: {over_eighteen: 0, over_twenty_one: 1, chaperone_under_eighteen: 2}
  enum frequency: {ongoing: 0, one_time: 1}
  enum status: {recruiting: 0, not_recruiting: 1}

end
