class Identity < ActiveRecord::Base
  belongs_to :user

  def self.find_for_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create
  end
end
