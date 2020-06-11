class BoardSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :rows, :columns, :mines, :finished_at, :state

  has_many :cells
end
