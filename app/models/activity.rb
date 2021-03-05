class Activity < ApplicationRecord
  belongs_to :volunteer
  belongs_to :role
  scope :user_set, -> (user) {joins(:volunteer).where(volunteers: {user_id: user.id})}
  scope :newest, -> {order(date: :desc)}
  scope :oldest, -> {order(:date)}

  # def self.user_set(user)
  #   joins(:volunteer).where(volunteers: {user_id: user.id})
  # end

end
