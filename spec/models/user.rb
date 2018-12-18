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

  # =========== スコープのテスト ==============
  describe 'scope' do
    describe 'approve_to_receive_mail' do
      subject{ User.approve_to_receive_mail }
      context 'メール通知を許可している場合' do
        let!(:approve_mail_user){ create(:user, mail_receive: true) }
        it '検索に含まれる' do; expect(subject).to include approve_mail_user; end
      end
      context 'メール通知を許可していない場合' do
        let!(:not_approve_mail_user){ create(:user, mail_receive: false) }
        it '検索に含まれない' do; expect(subject).not_to include not_approve_mail_user; end
      end
    end
  end
end
