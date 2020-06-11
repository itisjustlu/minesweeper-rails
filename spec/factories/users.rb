FactoryBot.define do
  factory :user do
    email { "#{SecureRandom.uuid}@gmail.com" }
    password { '123456' }
    password_confirmation { '123456' }
  end
end