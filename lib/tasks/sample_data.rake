namespace :db do
  desc "Create the physics ninja"
  task populate: :environment do
    admin = User.create!(name: "physicsninja",
                 email: "susan@c4online.com",
                 password: "I2430ZXQZYhackit",
                 password_confirmation: "I2430ZXQZYhackit")
    admin.toggle!(:admin)
  end

#  desc "Fill database with sample data"
#  task populate: :environment do
#    admin = User.create!(name: "PhysicsKid",
#                 email: "kid@batman.org",
#                 password: "foobar",
#                 password_confirmation: "foobar")
#    admin.toggle!(:admin)
    
#    99.times do |n|
#      name  = "NewKid-#{n+1}"
#      email = "kid-#{n+1}@batman.org"
#      password  = "password"
#      User.create!(name: name,
#                   email: email,
#                   password: password,
#                   password_confirmation: password)
#    end

#    users = User.all(limit: 6)
#    50.times do
#      content = Faker::Lorem.paragraph(5)
#      users.each { |user| user.posts.create!(content: content) }
#    end

# Need to fix....all answers are pointing to post #300 for some reason
#    posts = Post.all(limit: 50)
#    content = Faker::Lorem.paragraph(5)
#    posts.each do |post|
#      response = post.responses.build(content: content)
#      response.user = admin
#      response.save!
#    end
#  end
end