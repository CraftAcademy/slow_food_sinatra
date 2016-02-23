require './lib/models/category'

describe Category do
  it { is_expected.to have_property :id }
  it { is_expected.to have_property :name }
  it { is_expected.to have_many :dishes }
end
