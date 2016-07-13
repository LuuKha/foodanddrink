User.create name: "admin",
  email: "admin@admin.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true

User.create name: "nobita",
  email: "nobita@123.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true

User.create name: "user",
  email: "user@user.com",
  password: "123456",
  password_confirmation: "123456"

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create name: name,
    email: email,
    password: password,
    password_confirmation: password,
    is_admin: false
end
Category.create name: "Lemon"

Product.create name: "name",
  content: "content"
  20.times do |n|
  name = "Product #{n+1}"
  content = "Content for #{n+1}: Join my online book signing where I would like
    to dedicate these limited first editions to a lucky few. "
  Product.create name: name,
    content: content,
    price: 15000,
    category_id: 1,
    quantity: 1,
    classify: 1
  end
20.times do |n|
  content = Faker::Lorem.sentence(5)
  Comment.create content: content,
  user_id: n+1,
  product_id: n+1
end
