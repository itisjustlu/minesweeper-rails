class Cell < ApplicationRecord
  belongs_to :board

  validates :row, presence: true
  validates :column, presence: true

  enum flag: {
    empty: 0,
    mark: 1,
    red: 2
  }

  def click!
    return unless can_click?
    update(clicked: true)
  end

  def mark!
    return unless can_click?
    update(flag: :mark)
  end

  def red_flag!
    return unless can_click?
    update(flag: :red)
  end

  def restore_flag!
    return unless can_click?
    update(flag: :empty)
  end

  def can_click?
    !clicked?
  end
end
