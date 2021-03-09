class Activity < ApplicationRecord
  belongs_to :volunteer
  belongs_to :role

  validates :date, :duration, :volunteer_id, :role_id, presence: true
  validates :duration, numericality: {greater_than: 0, less_than_or_equal_to: 24} #make it a float?
  validate :date_cannot_be_in_future

  scope :newest, -> {order(date: :desc)}
  scope :oldest, -> {order(:date)}

  def self.apply_query(query)
    if query.present?
      if query == "oldest"
        oldest.includes(:volunteer, :role)
      elsif query == "newest" || query == "date"
        newest.includes(:volunteer, :role)
      elsif query == "name"
        includes(:volunteer, :role).order('volunteers.last_name')
      elsif query == "role"
        includes(:volunteer, :role).order('roles.title') #doesn't work with includes in nested route only joins
      elsif query == "duration"
        includes(:volunteer, :role).order(duration: :desc)
      else #this is repeated in the search_by_full_name method in volunteer model but calling that method here doesn't work
        q = "%#{query}"
        includes(:volunteer, :role).where("first_name || ' ' || last_name LIKE ? OR first_name LIKE ? OR last_name LIKE ?", q, q, q)
      end
    else
      newest.includes(:volunteer, :role) #this greatly speeds up 
    end
  end

  private
  def date_cannot_be_in_future
    if date && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end
end
