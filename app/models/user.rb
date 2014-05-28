class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:twitter, :facebook]

  def self.find_for_oauth(auth)
    identity      = Identity.find_for_oauth(auth)
    user          = (identity.user || identity.build_user)
    user.email    = (auth.info.email || "#{auth.uid}@example.com")
    user.password = Devise.friendly_token[0,20]
    user.name     = auth.info.name
    user.save!
    identity.update(user: user) unless identity.user_id
    user
  end
end
