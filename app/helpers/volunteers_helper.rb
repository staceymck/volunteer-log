module VolunteersHelper

  def display_age_group(volunteer)  
    volunteer.age_group.gsub('_', " ").gsub("twenty one", "21").gsub("eighteen", "18").capitalize
  end

  def display_phone(phone)
    phone.gsub(".", "-")
  end
end