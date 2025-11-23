users = [
  { name: "dummy user", email: "dummy@example.com", password: "dummypass@1", password_confirmation: "dummypass@1" }
]

users.each do |user|
  User.find_or_create_by!(email: user[:email]) do |u|
    u.name = user[:name]
    u.password = user[:password]
    u.password_confirmation = user[:password_confirmation]
  end
end
