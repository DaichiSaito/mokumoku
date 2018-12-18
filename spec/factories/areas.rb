# == Schema Information
#
# Table name: areas
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tokyo      :boolean          default(TRUE), not null
#

FactoryBot.define do
  factory :area do
  end
end

