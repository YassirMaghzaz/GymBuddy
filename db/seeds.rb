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

# Clear existing data
User.destroy_all
Profile.destroy_all
Gym.destroy_all
Match.destroy_all
Objective.destroy_all
Preference.destroy_all
ProfileImage.destroy_all

require 'cloudinary'
require 'cloudinary/uploader'
require 'cloudinary/utils'

# Create users with emails and passwords
users_data = [
  { email: "fatima@email.com", password: "password123" },
  { email: "amine@email.com", password: "password123" },
  { email: "sara@email.com", password: "password123" }
]

# Create users
users = users_data.map do |user_data|
  User.create!(user_data)
end

# Create profiles
profiles_data = [
  {
    first_name: "Fatima",
    last_name: "El Aouni",
    age: 27,
    gender: "female",
    location: "Casablanca",
    bio: "Fitness enthusiast and healthy lifestyle advocate.",
    availability: "Monday to Friday",
    level: "Intermediate",
    user_id: users[0].id
  },
  {
    first_name: "Amine",
    last_name: "Bennani",
    age: 30,
    gender: "male",
    location: "Rabat",
    bio: "Bodybuilding lover, ready to share tips.",
    availability: "Every day",
    level: "Advanced",
    user_id: users[1].id
  },
  {
    first_name: "Sara",
    last_name: "Bekkali",
    age: 24,
    gender: "female",
    location: "Casablanca",
    bio: "Loves yoga and meditation.",
    availability: "Weekends",
    level: "Beginner",
    user_id: users[2].id
  }
]

# Create profiles
profiles = profiles_data.map do |profile_data|
  Profile.create!(profile_data)
end

# Upload images to Cloudinary and associate with profiles
profile_images_data = [
  { profile: profiles[0], image_url: "https://images.unsplash.com/photo-1521566652839-697aa473761a?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
  { profile: profiles[1], image_url: "https://images.unsplash.com/photo-1519713880332-91cfe19a59dd?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" },
  { profile: profiles[2], image_url: "https://images.unsplash.com/photo-1619365734050-cb5e64a42d43?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTU5fHxwZXJzb258ZW58MHx8MHx8fDI%3D" }
]

# Associate Cloudinary images with profiles
profile_images_data.each do |data|
  uploaded_image = Cloudinary::Uploader.upload(data[:image_url])
  # Create a ProfileImage record with the uploaded Cloudinary URL
  ProfileImage.create!(profile: data[:profile], image: uploaded_image['url'])
end

# Create gyms for profiles
gyms_data = [
  { name: "Passage Fitness", address: "123 Fitness St", city: "Casablanca", country: "Morocco", profile_id: profiles[0].id },
  { name: "Anytime Fitness", address: "456 Workout Ave", city: "Rabat", country: "Morocco", profile_id: profiles[1].id },
  { name: "Passage Fitness", address: "123 Fitness St", city: "Casablanca", country: "Morocco", profile_id: profiles[2].id }
]

# Create gyms
gyms = gyms_data.map do |gym_data|
  Gym.create!(gym_data)
end

# Create preferences for profiles
preferences_data = [
  { workout_days: "Monday, Wednesday, Friday", workout_type: "Strength Training", profile_id: profiles[0].id },
  { workout_days: "Every day", workout_type: "Bodybuilding", profile_id: profiles[1].id },
  { workout_days: "Saturday, Sunday", workout_type: "Yoga", profile_id: profiles[2].id }
]

# Create preferences
preferences_data.each do |preference_data|
  Preference.create!(preference_data)
end

# Create objectives for profiles
objectives_data = [
  { title: "Lose weight", description: "I want to lose 5kg within 3 months.", status: "active", progress: 20.0, start_at: Date.today, end_at: Date.today + 3.months, target_weight: 70.0, current_weight: 75.0, profile_id: profiles[0].id },
  { title: "Gain muscle mass", description: "Looking to gain 10kg of muscle.", status: "active", progress: 50.0, start_at: Date.today, end_at: Date.today + 6.months, target_weight: 90.0, current_weight: 80.0, profile_id: profiles[1].id },
  { title: "Improve flexibility", description: "Increase flexibility through yoga.", status: "active", progress: 10.0, start_at: Date.today, end_at: Date.today + 2.months, target_weight: nil, current_weight: nil, profile_id: profiles[2].id }
]

# Create objectives
objectives_data.each do |objective_data|
  Objective.create!(objective_data)
end


puts "Seed data created successfully!"
