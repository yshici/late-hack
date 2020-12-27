require 'rails_helper'

RSpec.describe "Schedules", type: :system do
  let(:user) { create(:user) }
  let(:schedule) { create(:schedule, user: user) }

  describe 'ログイン前' do
    describe 'スケジュール一覧' do
      context 'スケジュール一覧ページへアクセス' do
        it 'スケジュール一覧ページへのアクセスが失敗する' do
          visit schedules_path
          expect(current_path).to eq root_path
        end
      end
    end
    describe 'スケジュール新規登録' do
      context 'スケジュール新規登録ページへアクセス' do
        it 'スケジュール新規登録ページへのアクセスが失敗する' do
          visit new_schedule_path
          expect(current_path).to eq root_path
        end
      end
    end
    describe 'スケジュール詳細' do
      context 'スケジュール詳細ページへアクセス' do
        it 'スケジュール詳細ページへのアクセスが失敗する' do
          visit schedule_path(schedule)
          expect(current_path).to eq root_path
        end
      end
    end
    describe 'スケジュール編集' do
      context 'スケジュール編集ページへアクセス' do
        it 'スケジュール編集ページへのアクセスが失敗する' do
          visit edit_schedule_path(schedule)
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }
    describe 'スケジュール一覧' do
      context 'スケジュール一覧ページへアクセス' do
        it 'スケジュール一覧ページが表示される' do
          visit schedules_path
          expect(current_path).to eq schedules_path
        end
      end
    end

    describe 'スケジュール新規登録' do
      context 'スケジュール新規登録ページへアクセス' do
        it 'スケジュール新規登録ページが表示される' do
          visit new_schedule_path
          expect(current_path).to eq new_schedule_path
        end
      end
    end
    describe 'スケジュール詳細' do
      context 'スケジュール詳細ページへアクセス' do
        it 'スケジュール詳細ページが表示される' do
          visit schedule_path(schedule)
          expect(current_path).to eq schedule_path(schedule)
          expect(page).to have_content schedule.name
          expect(page).to have_content schedule.meeting_time.strftime("%Y/%m/%d %H:%M")
          expect(page).to have_content schedule.destination_name
        end
      end
    end
    describe 'スケジュール編集' do
      context 'スケジュール編集ページへアクセス' do
        it 'スケジュール編集ページが表示される' do
          visit edit_schedule_path(schedule)
          expect(current_path).to eq edit_schedule_path(schedule)
        end
      end
    end
    describe 'スケジュール削除' do
      context 'スケジュールを削除する' do
        it 'スケジュールの削除が成功する' do
          visit schedule_path(schedule)
          click_link '削除'
          expect(page.accept_confirm).to eq '削除しますか？'
          expect(current_path).to eq schedules_path
          expect(page).to have_content 'スケジュールを削除しました'
          expect(page).not_to have_content schedule.name
        end
      end
    end
  end
end
