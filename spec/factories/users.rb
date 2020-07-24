FactoryBot.define do
  factory :user do
    email { 'test@test.test' }
    password { '123123' }
    password_confirmation { '123123' }
  end
end
