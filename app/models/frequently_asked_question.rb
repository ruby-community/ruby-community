class FrequentlyAskedQuestion < ActiveRecord::Base
  def self.topics
    order(:position).uniq.pluck(:topic)
  end
end
