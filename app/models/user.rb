class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  has_many :volunteers
  has_many :roles
  has_many :activities, through: :volunteers
  
  def self.create_from_omniauth(auth)
    self.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
      u.username = auth['info']['name'] || auth['info']['nickname']
      u.email = auth['info']['email']
      u.password = SecureRandom.hex(16)
    end
  end

  #Cummulative totals
  def total_hours
    activities.sum(:duration)
  end

  def total_activities
    activities.count
  end

  def unique_volunteers
    volunteers.uniq.count
  end

  #Monthly totals
  def hours_this_month
    activities.where("cast(strftime('%m', date) as int) = ?", Date.today.month).sum(:duration)
  end

  def activities_this_month
    activities.where("cast(strftime('%m', date) as int) = ?", Date.today.month).count
  end

  # def unique_volunteers_this_month
  #   activities.where("cast(strftime('%m', date) as int) = ?", Date.today.month).group('volunteer_id')
  # end

  # def new_volunteers_this_month
  #   activities.where("cast(strftime('%m', date) as int) = ?", Date.today.month).group('volunteer_id')
  # end

  #Yearly totals
  def hours_this_year
    activities.where("cast(strftime('%Y', date) as int) = ?", Date.today.year).sum(:duration)
  end

  def activities_this_year
    activities.where("cast(strftime('%Y', date) as int) = ?", Date.today.year).count
  end

  # def unique_volunteers_this_year
  # end

  # def new_volunteers_this_year
  # end
end
