
puts "Seeding Roles:"

roles = ['admin', 'campus_patron', 'scanned_book_creator']
roles.each do | name |
  puts "  #{name}"
  Role.where(name: name).first_or_create(name: name)
end

puts "Seeding Users:"

u = {
  email: 'admin@example.edu',
  roles: ['admin'],
  pw: 'a password'
}

puts "  #{u[:email]}"
new_user = User.where(email: u[:email]).first_or_create(email: u[:email], password: u[:pw])
u[:roles].each do |r|
  new_user.roles << Role.where(name: r)
end
new_user.save!
