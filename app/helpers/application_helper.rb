module ApplicationHelper
  
  def display_hours(hours)
    sprintf("%g", hours)
  end

  def display_yes_no(boolean_attribute)
    boolean_attribute == false ? "No" : "Yes"
  end

  def remove_underscores(attribute) 
    attribute.gsub("_", " ").capitalize
  end

  def display_date(date)
    date.try {strftime("%m/%d/%Y") } #Rails guide suggests &. as safe navigation operator - date.&(strftime("%m/%d/%Y"))
  end

  def message_if_no_records(collection)
    (tag.tr tag.td('No records to display')) if collection.size == 0 
  end
end
