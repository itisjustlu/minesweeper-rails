class CellSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :row, :column, :flag, :mines_around, :type, :board_id

  attribute :clicked do |object|
    object.clicked?
  end
end
