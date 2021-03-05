module RolesHelper

  def display_age_requirement(role)
    role.age_requirement.gsub("_", " ").gsub("twenty one", "21").gsub("eighteen", "18").capitalize
  end
end
