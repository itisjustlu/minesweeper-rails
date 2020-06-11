class CellSerializer
  include FastJsonapi::ObjectSerializer
  attributes :row, :column, :flag, :mines_around, :type

  attribute :clicked do |object|
    object.clicked?
  end
end
