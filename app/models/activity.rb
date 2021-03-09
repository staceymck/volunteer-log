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
      case query
      when "oldest"
        oldest.includes(:volunteer, :role)
      when "newest"
        newest.includes(:volunteer, :role)
      when "name"
        includes(:volunteer, :role).order('volunteers.last_name')
      when "role"
        includes(:volunteer, :role).order('roles.title')
      when "duration"
        includes(:volunteer, :role).order(duration: :desc)
      else
        q = "%#{query}"
        includes(:volunteer, :role).where("first_name || ' ' || last_name LIKE ? OR first_name LIKE ? OR last_name LIKE ?", q, q, q)
      end
    else
      newest.includes(:volunteer, :role) #includes greatly speeds up querying
    end
  end

  private
  def date_cannot_be_in_future
    if date && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end
end
