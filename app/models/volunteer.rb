class Volunteer < ApplicationRecord
  belongs_to :user
  has_many :activities
  has_many :roles, through: :activities
  enum age_group: {over_eighteen: 0, over_twenty_one: 1, under_eighteen: 2}
  enum background_check_status: {incomplete: 0, approved: 1, flagged: 2}
  scope :alpha, -> {order(:last_name)}
  validates :first_name, :last_name, :background_check_status, :age_group, presence: true
  #validates presence of either email or phone
  #validates that it has a user?
  #validate that all enum fields are integers?

  def full_name
    "#{first_name} #{last_name}"
  end

  def total_hours
    activities.sum(:duration)
  end

  def start_year
    activities.minimum(:date).year
  end

  def self.apply_query(query)
    if query.present?
      if query == "last_name"
        alpha
      elsif query == "first_name"
        order(:first_name)
      elsif query == "date"
        joins(:activities).group('volunteers.id').order('max(date) desc')
      elsif query == "hours"
        joins(:activities).group('volunteers.id').order('sum(duration) desc')
      else
        where("first_name LIKE ?", "%#{query}%")
        #switch to search_by_full_name when it's ready
      end
    else
      alpha
    end
  end

  # def self.search_by_full_name(query)
  #   q = "%#{query}%"
  #   where("first_name + ' ' + last_name LIKE ? OR last_name + ' ' + first_name LIKE ?", [q, q])  
  # end

  def last_activity_date
    activities.maximum(:date)
  end
end
