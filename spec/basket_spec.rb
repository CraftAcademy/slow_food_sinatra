require './lib/models/basket'

describe Basket do
  it { is_expected.to have_property :id }
  it { is_expected.to have_property :created_at }
  it { is_expected.to have_property :created_on }
  it { is_expected.to have_property :updated_at }
  it { is_expected.to have_property :updated_on }

  it { is_expected.to have_many :basket_items }
  it { is_expected.to belong_to :user }

  let(:category) { Category.create(name: 'Starter') }
  let(:creator) { User.create(username: 'Admin', password: 'password', password_confirmation: 'password', admin: true) }
  let(:buyer) { User.create(username: 'Buyer', password: 'password', password_confirmation: 'password', phone_number: '123456', email: 'buyer@test.com', admin: false) }

  subject { described_class.create(user: buyer) }

  let(:item_1) do
    Dish.create(name: 'Test 1', price: 50, category: category, user: creator)
  end
  let(:item_2) { Dish.create(name: 'Test 2', price: 10, category: category, user: creator) }


  it 'adds dish to basket as basket_item' do
    subject.add_item(item_1, 2)
    expect(subject.basket_items.count).to eql 1
  end
end
