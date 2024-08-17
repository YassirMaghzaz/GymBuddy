# Clear existing data
Match.destroy_all
Objectif.destroy_all
Preference.destroy_all
Profile.destroy_all
User.destroy_all
Gym.destroy_all

# Create gyms
gyms = []
5.times do |i|
  gyms << Gym.create(name: "Gym#{i + 1}")
end

# Create users with profiles, objectifs, and preferences
10.times do |i|
  user = User.create(
    email: "user#{i + 1}@example.com",
    password: "password",
    password_confirmation: "password"
  )

  if user.persisted?
    profile = Profile.create(
      first_name: "First#{i + 1}",
      last_name: "Last#{i + 1}",
      age: 20 + i,
      gender: i.even? ? "Male" : "Female",
      bio: "This is the bio for user#{i + 1}",
      level: ["Beginner", "Intermediate", "Advanced"].sample,
      user_id: user.id
    )

    if profile.persisted?
      # Create one objectif for each profile
      profile.objectifs.create(
        title: "Objective for user#{i + 1}",
        description: "This is the objective description for user#{i + 1}",
        status: ["Not Started", "In Progress", "Completed"].sample,
        progress: rand(0..100),
        start_at: DateTime.now - rand(1..10).days,
        end_at: DateTime.now + rand(1..10).days,
        target_weight: rand(60..100),
        current_weight: rand(60..100)
      )

      # Create preferences for each profile
      gym = gyms.sample  # Assign a random gym from the created gyms
      profile.preferences.create(
        workout_days: ["Monday", "Wednesday", "Friday"].join(", "),
        gym: gym,
        workout_type: ["Cardio", "Strength", "Mixed"].sample
      )
    else
      puts "Profile for user#{i + 1} could not be saved: #{profile.errors.full_messages.join(', ')}"
    end
  else
    puts "User#{i + 1} could not be created: #{user.errors.full_messages.join(', ')}"
  end
end

puts "Seed completed successfully!"
