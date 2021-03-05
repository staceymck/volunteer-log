module ApplicationHelper
  def display_hours(hours)
    sprintf("%g", hours)
  end

  def display_yes_no(boolean_attribute)
    boolean_attribute == 0 ? "No" : "Yes"
  end
end
