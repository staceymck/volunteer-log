module DashboardHelper
  
  def new_user_welcome
    if @user.volunteers.size == 0 && @user.roles.size == 0
    content_tag(:div, content_tag(:p, "This dashboard will display stats as you add volunteers
     roles and activity records.") + content_tag(:p, "To get started, add a volunteer and a role.
     Then start tracking each volunteer engagement as an activity record."), class: "welcome")
    end
  end
end
