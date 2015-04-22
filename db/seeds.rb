# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Rails.env.production?

  # TODO: put these in a YAML file so that FactoryGirl can use them as well.
  users = [
    {
      email: 'admin@example.edu',
      roles: ['admin'],
      pw: 'a password'
    },
    {
      email: 'fmeekins@example.edu',
      roles: ['campus_patron'],
      pw: 'the3pistolizer'
    },
    {
      email: 'technician@example.edu',
      roles: ['scanned_book_creator'],
      pw: 'ilikeb00ks'
    }
  ]

  puts "Seeding Roles:"

  roles = users.map { |u| u[:roles] }.flatten.uniq

  roles.each do | name |
    puts "  #{name}"
    Role.where(name: name).first_or_create(name: name)
  end

  puts "Seeding Users"

  users.each do |u|
    puts "  #{u[:email]}"
    new_user = User.where(email: u[:email]).first_or_create(email: u[:email], password: u[:pw])
    u[:roles].each do |r|
      new_user.roles << Role.where(name: r)
    end
    new_user.save!
  end
end
