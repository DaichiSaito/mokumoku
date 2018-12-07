# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null
#  crypted_password :string(255)
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  last_name        :string(255)
#  first_name       :string(255)
#  image            :string(255)
#

require 'rails_helper'

RSpec.describe User, type: :model do

end
