class Role < ApplicationRecord
  belongs_to :user
  has_many :activities
  has_many :volunteers, through: :activities
  enum age_requirement: {over_eighteen: 0, over_twenty_one: 1, chaperone_under_eighteen: 2}
  enum frequency: {ongoing: 0, one_time: 1}
  enum status: {recruiting: 0, no_current_opportunities: 1}
  scope :alpha, -> {order(:title)}

  def self.apply_query(query)
    if query.present?
      if query == "recruiting"
        where(status: "recruiting")
      elsif query == "family-friendly"
        where(age_requirement: chaperone_under_eighteen)
      else
        where("title LIKE ?", "%#{query}%")
      end
    else
      all
    end
  end

end

