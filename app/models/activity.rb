class Activity < ApplicationRecord
  belongs_to :volunteer
  belongs_to :role
  scope :user_set, -> (user) {joins(:volunteer).where(volunteers: {user_id: user.id})}
  scope :newest, -> {order(date: :desc)}
  scope :oldest, -> {order(:date)}

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
