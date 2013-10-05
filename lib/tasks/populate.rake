namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    20.times do |n|
      User.create!(
        name: Faker::Name.first_name
      )
    end
  end
end
