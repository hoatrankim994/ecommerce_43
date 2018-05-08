User.create!(name:  "hoa",
             email: "hoa@gmail.com",
             address: "1/27 Luong Dac Bang P Tan Thoi Hoa Q Tan Phu",
             phone: "0909090909",
             gender: "male",
             password: "123123",
             password_confirmation: "123123",
             role: 0,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  phone = "0949779858"
  gender = "female"
  address = "1/11 Luong dac bang"
  User.create!(name:  name,
               phone: phone,
               gender: gender,
               email: email,
               address: address,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

Category.create!(title: "Fantasy",
             parent_id: "0"
             )
Category.create!(title: "Technology",
             parent_id: "0"
             )
Category.create!(title: "Biography",
             parent_id: "0"
             )
