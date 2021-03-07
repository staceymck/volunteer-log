class Role < ApplicationRecord
  belongs_to :user
  has_many :activities
  has_many :volunteers, through: :activities
  enum age_requirement: {over_eighteen: 0, over_twenty_one: 1, chaperone_if_under_eighteen: 2}
  enum frequency: {ongoing: 0, one_time: 1}
  enum status: {recruiting: 0, no_current_opportunities: 1}
  scope :alpha, -> {order(:title)}
  validates :title, :age_requirement, :frequency, :status, :background_check_required, presence: true
  #validates :background_check_required, inclusion: [true, false]
  #validates that it belongs to a user

  def self.apply_query(query)
    if query.present?
      if query == "recruiting"
        where(status: "recruiting")
      elsif query == "status"
        order(:status)
      elsif query == "age"
        order(:age_requirement)
      elsif query == "frequency"
        order(:frequency)
      elsif query == "family-friendly"
        where(age_requirement: :chaperone_if_under_eighteen)
      elsif query == "title"
        alpha
      else
        where("title LIKE ?", "%#{query}%")
      end
    else
      alpha
    end
  end

end

