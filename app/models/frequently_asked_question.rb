class FrequentlyAskedQuestion < ActiveRecord::Base
  def self.topics
    order(:position).pluck(:topic).uniq # order(:position).uniq.pluck(:topic) would be nicer, but PG can't do that
  end
end
