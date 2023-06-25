# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
agent = Agent.find_or_create_by({
  code: "PCECAGT11",
  name: "Daniel Zamora",
  address: "galera 2703",
  phone: "1231231231",
  cellphone: "1231231231",
  active: 1,
  type: "OFICIAL"
})

user = User.find_or_create_by({
  email: "daniel.zamoraf@gmail.com",
  name: "Daniel Ernesto",
  lastname: "Zamora Flores",
  agent: agent
})
user.password = "*890212*"
user.password_confirmation = "*890212*"
user.save(validate: false)