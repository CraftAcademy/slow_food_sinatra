class BasketItem
  include DataMapper::Resource

  property :id, Serial, key: true, required: false
  property :qty, Integer

  has 1, :dish, through: Resource
  belongs_to :basket
end
