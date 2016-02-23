class Basket
  include DataMapper::Resource

  property :id, Serial, key: true, required: false
  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date

  has n, :basket_items
  belongs_to :user

  def total
    @total = 0
    basket_items.each do |item|
      @total += (item.dish.price * item.qty)
    end
    @total
  end

  def add_item(obj, qty)
    BasketItem.create(dish: obj, qty: qty, basket: self)
  end

  def set_pick_up_time
    Time.now + 1800
  end

  def buyer_name
    name = User.first(id: user_id)
    name.username
  end
end
