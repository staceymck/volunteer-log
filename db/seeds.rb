#Create 3 users
User.create!(username: 'Ahab', email: 'cap@savewhales.org', password: '123', password_confirmation: '123')
User.create!(username: 'Broc', email: 'broc@lettuceeat.org', password: '1234', password_confirmation: '1234')
User.create!(username: 'Brutus', email: 'mjbrutus@deescalate-skills.com', password: '12345', password_confirmation: '12345')

#Create 10 volunteers per user
User.all.each do |u|
  10.times do
    vol = u.volunteers.build(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone: Faker::PhoneNumber.phone_number,
      email: Faker::Internet.email,
      occupation: Faker::Job.title,
      employer: Faker::Company.name,
      interests: Faker::Lorem.paragraph,
      background_check_status: rand(0..1),
      birthday: Faker::Date.birthday(min_age: 16)
    )
    #Add age group dependent on birthday
    start_time = vol.birthday
    end_time = Date.today
    diff = TimeDifference.between(start_time, end_time).in_years
    
    if diff < 18 
      vol.age_group = "under_eighteen"
    elsif diff > 18 && diff < 21
      vol.age_group = "over_eighteen"
    else
      vol.age_group = "over_twenty_one"
    end
    
    vol.save! #save volunteer record
  end
end

#Set 1 volunteer per user to flagged background check
User.all.each do |u|
  vol = u.volunteers.last
  vol.background_check_status = "flagged"
  vol.save! 
end

#Create 10 Roles
TITLES = ["Afterschool tutor", "Advocacy lead", "Mentor", "Outreach team", "Activity assistant", "Meal delivery", "Program ambassador", "Front desk support", "Clean-up day team", "Activity lead"]
DAYS = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

User.all.each do |u|
  num = 0
  while num < 10 do
    u.roles.create!(
      title: TITLES[num],
      description: Faker::Lorem.paragraphs(number: 3).join(" "),
      age_requirement: [0,1,2].sample,
      frequency: [0,1].sample,
      days: DAYS.sample,
      background_check_required: ["true", "false"].sample,
      status: [0,1].sample
    )
    num += 1
  end
end

#Create 10 activity records per volunteer
Volunteer.all.each do |vol|
  roles = vol.user.roles
  eligible_roles = []
  roles.each do |role|
    if role.background_check_required? && vol.approved? 
      eligible_roles << role
    elsif vol.age_group == role.age_requirement
      eligible_roles << role
    end
    #elibible if volunteer is under 18 and role is open to those under 18
    # elsif vol.under_eighteen? && role.chaperone_under_eighteen?
    #   eligible_roles << role
    # #eligible if volunteer is over 18+ and position is open to those over 18
    # elsif role.over_eighteen? && vol.over_eighteen? 
    #   eligible_roles << role
    # elsif role.over_twenty_one? && vol.over_twenty_one?
    #   eligible_roles << role 
  end

  10.times do 
    vol.activities.create!(
      duration: Faker::Number.between(from: 1, to: 3),
      date: Faker::Date.between(from: 5.years.ago, to: Date.today),
      role_id: eligible_roles.sample.id
    )
  end
end