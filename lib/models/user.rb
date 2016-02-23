
class User
  include DataMapper::Resource
  attr_accessor :password_confirmation

  property :id, Serial, key: true
  property :username, String, length: 128, unique: true
  property :admin, Boolean, default: false
  property :password, BCryptHash
  property :email, String, format: :email_address,
                           messages: {
                             is_unique: 'We already have that email',
                             format: "Doesn't look like an email address to me ..."
                           }
  property :phone_number, Text
  has n, :dishes
  has n, :baskets

  validates_presence_of :email, if: ->(t) { t.admin == false }, message: 'Please add email adress'
  validates_presence_of :phone_number, if: ->(t) { t.admin == false }, message: 'Please provide phone number'
  validates_confirmation_of :password, message: 'Password not matching confirmation'

  def authenticate(attempted_password)
    password == attempted_password
  end

  def initialize(options = {})
    self.admin = options[:admin] || false
    super
  end

  def self.admins
    all(admin: true)
  end

  def self.visitors
    all(admin: false)
  end
end
