require 'faker'

10.times do
  User.create(name: Faker::Internet.user_name,
              password: "password")
end

10.times do
  Post.create(title: Faker::Commerce.product_name,
              url: Faker::Internet.url,
              user_id: rand(1..10))
end

20.times do
  Comment.create(content: Faker::Company.bs,
                 post_id: rand(1..10),
                 user_id: rand(1..10))
end
