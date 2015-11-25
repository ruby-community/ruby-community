class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(data)
    handle = data['info']['nickname']
    find_by github: handle
  end
end
