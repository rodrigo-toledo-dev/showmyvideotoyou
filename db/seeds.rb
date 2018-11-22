# frozen_string_literal: true

require 'faker'

User.create(name: Faker::Name.unique.name, email: 'rodrigo@rtoledo.inf.br',
  password: 'asdqwe123', password_confirmation: 'asdqwe123')

30.times do
  User.create(name: Faker::Name.unique.name, email: Faker::Internet.email,
              password: 'asdqwe123', password_confirmation: 'asdqwe123')
end