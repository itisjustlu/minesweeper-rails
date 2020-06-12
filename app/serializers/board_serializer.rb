class BoardSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :rows, :columns, :mines, :finished_at, :state, :created_at

  has_many :cells
end
