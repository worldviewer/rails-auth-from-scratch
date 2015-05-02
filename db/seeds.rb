# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

chris = User.create({ email: 'plasmasrevenge@yahoo.com',
				   password: '123456'})

jami = User.create({ email: 'jamikrueger@yahoo.com',
				   password: 'abcdef'})

