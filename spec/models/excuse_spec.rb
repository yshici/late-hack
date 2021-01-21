require 'rails_helper'

RSpec.describe Excuse, type: :model do
  describe 'バリデーション確認' do
    let(:excuse) { create(:excuse) }
    it '内容、遅刻時間があれば有効な状態であること' do
      expect(excuse).to be_valid
    end

    it '内容が無ければ無効な状態であること' do
      excuse.content = nil
      expect(excuse).to be_invalid
    end

    it '遅刻時間が無ければ無効な状態であること' do
      excuse.late_time = nil
      expect(excuse).to be_invalid
    end

    it '内容が重複している場合無効な状態であること' do
      other_excuse = build(:excuse, content: excuse.content)
      expect(other_excuse).to be_invalid
    end

    it '内容が重複していない場合有効な状態であること' do
      other_excuse = build(:excuse)
      expect(other_excuse).to be_valid
    end
  end
end
