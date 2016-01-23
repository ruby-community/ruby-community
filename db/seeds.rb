# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

position = 0
FrequentlyAskedQuestion.destroy_all
YAML.load_file('db/seeds/all/faq.yaml').each do |topic, faqs|
  faqs.each do |question, answer|
    position += 1
    FrequentlyAskedQuestion.create! topic: topic, position: position, question: question, answer: answer
  end
end

time = Time.zone.local(2016,1,1)
%w[
  apeiros
  drbrain
  radar
  zzak
  adaedra
  aredridel
  banister
  baweaver
  CoralineAda
  havenwood
  jhass
  leejarvis
  miah/
  Mon-Ouie
  djberg96
  seanstickle
  slyphon
  workmad3
  zenspider
].each.with_index(1) do |user, idx|
  User.create!(id: idx, github: user, created_at: time, updated_at: time)
end
