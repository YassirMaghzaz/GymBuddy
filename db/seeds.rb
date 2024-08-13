# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# User.all.each do |user|
#   user.create_profile unless user.profile
# end




# db/seeds.rb

require 'faker'

# Clear existing data
User.destroy_all
Profile.destroy_all
Gym.destroy_all
Match.destroy_all
Objective.destroy_all
Preference.destroy_all
ProfileImage.destroy_all

# Create users and profiles
10.times do |i|
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password123', 
    password_confirmation: 'password123'
  )

  profile = Profile.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: rand(18..65),
    gender: ['Male', 'Female', 'Other'].sample,
    location: Faker::Address.city,
    bio: Faker::Lorem.paragraph,
    availability: 'Weekdays 6-8 AM, Weekends 8-10 AM',
    level: ['Beginner', 'Intermediate', 'Advanced'].sample,
    user_id: user.id
  )

  # Create a gym associated with the profile
  Gym.create!(
    name: "#{Faker::Company.name} Gym",
    address: Faker::Address.street_address,
    city: profile.location,
    country: Faker::Address.country,
    profile_id: profile.id
  )

  # Create an objective for the profile
  Objective.create!(
    title: "Lose #{rand(5..15)} kg",
    description: Faker::Lorem.sentence,
    status: ['In Progress', 'Completed', 'Pending'].sample,
    progress: rand(0..100),
    start_at: Faker::Date.backward(days: 60),
    end_at: Faker::Date.forward(days: 60),
    target_weight: rand(60..90),
    current_weight: rand(70..100),
    profile_id: profile.id
  )

  # Create preferences for the profile
  Preference.create!(
    workout_days: ['Monday', 'Wednesday', 'Friday'].sample,
    workout_type: ['Cardio', 'Strength', 'Flexibility'].sample,
    profile_id: profile.id
  )

  # Create a profile image
  ProfileImage.create!(
    profile_id: profile.id,
    image: Faker::Avatar.image(slug: profile.first_name.downcase, size: "100x100", format: "png")
  )
end

# Create some matches between profiles
profiles = Profile.all
profiles.each do |profile|
  2.times do
    matched_profile = profiles.where.not(id: profile.id).sample
    Match.create!(
      profile_id: profile.id,
      matched_profile_id: matched_profile.id,
      status: ['pending', 'accepted', 'rejected'].sample
    )
  end
end

puts "Seed data created successfully!"
