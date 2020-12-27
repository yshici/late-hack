require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション確認' do
    let(:user) { create(:user) }
    it '名前、メール、パスワード、パスワード確認があれば有効な状態であること' do
      expect(user).to be_valid
    end

    it '名前が無ければ無効な状態であること' do
      user.name = nil
      expect(user).to be_invalid
    end

    it 'メールが無ければ無効な状態であること' do
      user.email = nil
      expect(user).to be_invalid
    end

    it 'パスワードが無ければ無効な状態であること' do
      user = build(:user, password: nil)
      expect(user).to be_invalid
    end

    it 'パスワード確認が無ければ無効な状態であること' do
      user = build(:user, password_confirmation: nil)
      expect(user).to be_invalid
    end

    it 'メールが重複している場合無効な状態であること' do
      other_user = build(:user, email: user.email)
      expect(other_user).to be_invalid
    end

    it 'メールが重複していない場合有効な状態であること' do
      other_user = build(:user)
      expect(other_user).to be_valid
    end
  end
end
