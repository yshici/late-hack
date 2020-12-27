require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'バリデーション確認' do
    let(:schedule) { create(:schedule) }
    context '存在確認' do
      it '有効な状態であること' do
        expect(schedule).to be_valid
      end

      it '予定名が無ければ無効な状態であること' do
        schedule.name = nil
        expect(schedule).to be_invalid
      end

      it '予定時間が無ければ無効な状態であること' do
        schedule.meeting_time = nil
        expect(schedule).to be_invalid
      end

      it '予定時間が無ければ無効な状態であること' do
        schedule.meeting_time = nil
        expect(schedule).to be_invalid
      end

      it '目的地名称が無ければ無効な状態であること' do
        schedule.destination_name = nil
        expect(schedule).to be_invalid
      end

      it '目的地住所が無ければ無効な状態であること' do
        schedule.destination_address = nil
        expect(schedule).to be_invalid
      end

      it '目的地緯度が無ければ無効な状態であること' do
        schedule.destination_lat = nil
        expect(schedule).to be_invalid
      end

      it '目的地経度が無ければ無効な状態であること' do
        schedule.destination_lng = nil
        expect(schedule).to be_invalid
      end

      it '出発地名称が無ければ無効な状態であること' do
        schedule.start_point_name = nil
        expect(schedule).to be_invalid
      end

      it '出発地住所が無ければ無効な状態であること' do
        schedule.start_point_address = nil
        expect(schedule).to be_invalid
      end

      it '出発地緯度が無ければ無効な状態であること' do
        schedule.start_point_lat = nil
        expect(schedule).to be_invalid
      end

      it '出発地経度が無ければ無効な状態であること' do
        schedule.start_point_lng = nil
        expect(schedule).to be_invalid
      end
    end

    context '文字数確認' do
      it '予定名が255文字以下であれば有効な状態であること' do
        schedule.name = 'a'*255
        expect(schedule).to be_valid
      end

      it '予定名が255文字以下でなければ無効な状態であること' do
        schedule.name = 'a'*256
        expect(schedule).to be_invalid
      end

      it '概要が1000文字以下であれば有効な状態であること' do
        schedule.description = 'a'*1000
        expect(schedule).to be_valid
      end

      it '概要が1000文字以下でなければ無効な状態であること' do
        schedule.description = 'a'*1001
        expect(schedule).to be_invalid
      end
    end

    context '予定時間確認' do
      it '予定時間が現在時刻より10分以上前であれば無効な状態であること' do
        schedule.meeting_time = Time.now.ago(10.minutes)
        expect(schedule).to be_invalid
      end
    end
  end
end
