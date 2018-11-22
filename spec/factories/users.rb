# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    password { 'asdqwe123' }
    password_confirmation { 'asdqwe123' }
  end
end
