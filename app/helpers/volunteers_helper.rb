module VolunteersHelper

  def display_age_group(volunteer)  
    volunteer.age_group.gsub('_', " ").gsub("twenty one", "21").gsub("eighteen", "18").capitalize
  end

  def display_phone(phone)
    phone.gsub(".", "-")
  end

  def display_profile_image(volunteer)
    if volunteer.photo.present?
      image_tag("#{volunteer.photo}", alt: "#{volunteer.full_name}")
    else
      image_tag("undraw_polaroid_gg6n.svg", alt: "Volunteer profile image placeholder")
    end
  end
end