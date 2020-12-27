require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }
  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq schedules_path
      end
    end
    context 'メールアドレスが空欄' do
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインできませんでした'
        expect(current_path).to eq login_path
      end
    end
    context 'パスワードが空欄' do
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: ''
        click_button 'ログイン'
        expect(page).to have_content 'ログインできませんでした'
        expect(current_path).to eq login_path
      end
    end

    describe 'ログイン後' do
      before { login(user) }
      context 'ログアウトをクリック' do
        it 'ログアウトが成功する' do
          click_link 'ログアウト'
          expect(page).to have_content 'ログアウトしました'
          expect(current_path).to eq login_path
        end
      end
    end
  end
end
