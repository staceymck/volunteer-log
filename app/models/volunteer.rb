class Volunteer < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :roles, through: :activities

  enum age_group: {over_eighteen: 0, over_twenty_one: 1, under_eighteen: 2}
  enum background_check_status: {incomplete: 0, approved: 1, flagged: 2}
  
  validates :first_name, :last_name, :background_check_status, :age_group, presence: true
  validate :one_contact_method_must_be_present
  validate :birthdate_must_be_in_reasonable_past
  #validate that all enum fields are integers?

  scope :alpha, -> {order(:last_name, :first_name).distinct}

  
  def full_name
    "#{first_name} #{last_name}"
  end

  def total_hours
    activities.sum(:duration)
  end

  def start_year
    #activities.minimum(:date).year
    created_at.year #catches volunteers who haven't had an activity record yet
  end

  def last_activity_date
    activities.maximum(:date)
  end

  def self.apply_query(query)
    if query == "last_name"
      alpha
    elsif query == "first_name"
      order(:first_name)
    elsif query == "date"
      left_joins(:activities).group('volunteers.id').order('max(date) desc') #can left_joins be 'includes'?
    elsif query == "hours"
      left_joins(:activities).group('volunteers.id').order('sum(duration) desc')
    else
      search_by_full_name(query)
      #add a message to the page if no name matches instead of blank columns?
    end
  end

  def self.search_by_full_name(query)
    q = "%#{query}"
    where("first_name || ' ' || last_name LIKE ? OR first_name LIKE ? OR last_name LIKE ?", q, q, q)
  end

  private
  def one_contact_method_must_be_present
    if !email.present? && !phone.present?
      errors.add(:phone, "or email must be present")
    end
  end

  def birthdate_must_be_in_reasonable_past
    if birthday 
      if birthday > Date.today || birthday.year < 1910
        errors.add(:birthday, "must be in the past (but not ancient history)")
      end
    end
  end
end
