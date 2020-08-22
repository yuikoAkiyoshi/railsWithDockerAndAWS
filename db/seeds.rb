# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tag.create([
    { name: '日常' },
    { name: '仕事' },
    { name: '趣味' },
    { name: 'その他' },
])
user = User.new(:name => 'guest', :password => 'password')
user.save!