class Category
  include DataMapper::Resource

  property :id, Serial, key: true
  property :name, String, length: 128, unique: true, required: true

  has n, :dishes, through: Resource
end
