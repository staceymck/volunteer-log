class Activity < ApplicationRecord
  belongs_to :volunteer
  belongs_to :role
  scope :user_set, -> (user) {joins(:volunteer).where(volunteers: {user_id: user.id})}
  scope :newest, -> {order(date: :desc)}
  scope :oldest, -> {order(:date)}
  validates :date, :duration, :volunteer_id, :role_id, presence: true
  validates :duration, numericality: {greater_than: 0, less_than_or_equal_to: 24} #make it a float?
  validate :date_cannot_be_in_future
  #validate that volunteer id and role id must belong to user (and that it has both)?

  # def self.user_set(user)
  #   joins(:volunteer).where(volunteers: {user_id: user.id})
  # end

  def self.apply_query(query)
    if query.present?
      if query == "oldest"
        oldest
      elsif query == "newest"
        newest
      else
        where("first_name LIKE ?", "%#{query}%")  #need to make it searchable by first and/or last name
      end
    else
      newest
    end
  end

  #make this a private method?
  def date_cannot_be_in_future
    if date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end

  #Alternative if diving out search vs filter as 2 different types of queries
  # def self.filter_results(search, chosen_filter)
  #  if search.present?
  #   where("first_name LIKE ?", "%#{search}%")
  #  elsif chosen_filter.present?
  #   if chosen_filter == "oldest"
  #     oldest
  #   elsif chosen_filter == "newest"
  #     newest
  #   end
  #  else
  #    newest
  #  end
  # end

end
