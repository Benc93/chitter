require_relative 'peep'
require 'bcrypt'

class User

  include DataMapper::Resource

  property :id,            Serial
  property :name,          String
  property :email,         String, :unique => true, :format => :email_address
  property :username,      String, :unique => true
  property :password_hash, Text

  has n, :peeps

  def password=(password)
    @password = password
    self.password_hash = BCrypt::Password.create(password)
  end

  def self.authenticate(username, password)
    user = first(:username => username)
    if user && BCrypt::Password.new(user.password_hash) == password
      user
    else
      nil
    end
  end

end
