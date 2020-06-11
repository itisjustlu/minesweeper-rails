FactoryBot.define do
  factory :board do
    rows { 10 }
    columns { 10 }
    mines { 10 }
  end
end