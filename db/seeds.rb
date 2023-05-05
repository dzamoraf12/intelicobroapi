# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.find_or_create_by({
  email: "daniel.zamoraf@gmail.com",
  name: "Daniel Ernesto",
  lastname: "Zamora Flores"
})
user.password = "*890212*"
user.password_confirmation = "*890212*"
user.save(validate: false)