require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          visit new_user_path
          fill_in 'ユーザー名', with: 'user_test'
          fill_in 'メールアドレス', with: 'user_test@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録する'
          expect(page).to have_content 'ユーザー登録しました'
          expect(current_path).to eq login_path
        end
      end
    end
    describe 'ユーザー詳細' do
      context 'ユーザー詳細ページへアクセス' do
        it 'ユーザー詳細ページへのアクセスが失敗する' do
          visit user_path(user)
          expect(current_path).to eq root_path
        end
      end
    end
    describe 'ユーザー編集' do
      context 'ユーザー編集ページへアクセス' do
        it 'ユーザー編集ページへのアクセスが失敗する' do
          visit edit_user_path(user)
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe '一般ユーザーログイン後' do
    before { login(user) }
    describe 'ユーザー詳細' do
      context 'ユーザー編集ページへアクセス' do
        it 'ユーザー詳細ページへのアクセスが成功する' do
          visit user_path(user)
          expect(current_path).to eq user_path(user)
          expect(page).to have_content user.name
          expect(page).to have_content user.email
        end
      end
    end
    describe 'ユーザー編集' do
      context 'ユーザー編集ページへアクセス' do
        it 'ユーザー編集ページへのアクセスが成功する' do
          visit edit_user_path(user)
          expect(current_path).to eq edit_user_path(user)
        end
      end
      context 'フォームの入力値が正常' do
        it 'ユーザー情報の編集が成功する' do
          visit edit_user_path(user)
          fill_in 'ユーザー名', with: 'user_test'
          fill_in 'メールアドレス', with: 'user_test@example.com'
          click_button '更新する'
          expect(page).to have_content 'ユーザー情報を更新しました'
          expect(current_path).to eq user_path(user)
          expect(page).to have_content 'user_test'
        end
      end
      context '管理画面へアクセス' do
        it '管理画面へのアクセスが失敗する' do
          visit admin_root_path
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe '管理ユーザーログイン後' do
    let(:admin_user) { create(:user, :admin) }
    before { login(admin_user) }
    context '管理画面へアクセス' do
      it '管理画面へのアクセスが成功する' do
        visit admin_root_path
        expect(current_path).to eq admin_root_path
      end
    end
  end
end
