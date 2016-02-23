class Dish
  include DataMapper::Resource

  property :id, Serial, key: true
  property :name, String, length: 128, unique: true, required: true
  property :price, Integer, required: true

  belongs_to :user
  belongs_to :category
end
