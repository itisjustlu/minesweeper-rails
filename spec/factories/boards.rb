FactoryBot.define do
  factory :board do
    rows { 2 }
    columns { 2 }
    mines { 1 }
  end
end