class Ban < ActiveRecord::Base
  def ban_active?
    status == 'active' || status == 'suspended'
  end
end
