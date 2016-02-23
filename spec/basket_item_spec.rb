require './lib/models/basket_item'

describe BasketItem do
  it { is_expected.to have_property :id }
  it { is_expected.to have_property :qty }

  it { is_expected.to have_one :dish }
  it { is_expected.to belong_to :basket }
end
