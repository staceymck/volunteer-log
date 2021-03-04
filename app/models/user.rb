class User < ApplicationRecord
  has_secure_password
  has_many :volunteers
  has_many :roles
  has_many :activities, through: :volunteers
  
  def self.create_from_omniauth(auth)
    self.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
      u.username = auth['info']['name'] || auth['info']['nickname']
      u.email = auth['info']['email']
      u.password = SecureRandom.hex(16)
    end
  end
end
