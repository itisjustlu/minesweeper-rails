FactoryBot.define do
  factory :cell do
    row { 0 }
    column { 0 }
    type { 'Cells::None' }
    flag { 'empty' }

    association :board, factory: :board
  end
end