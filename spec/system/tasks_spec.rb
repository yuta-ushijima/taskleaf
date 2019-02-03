require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  # ユーザーAを作成しておく
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  # 作成者がユーザーAであるタスクを作成しておく
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

  before do
    # ログインする
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do

      let(:login_user) { user_a }
      it 'ユーザーAが作成したタスクが表示されること' do
        # 作成済みタスクの名称が表示されることを確認
        expect(page).to have_content '最初のタスク'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

       it 'ユーザーAが作成したタスクが表示されない' do
         # ユーザーAが作成したタスクの名称が表示されないことを確認
         expect(page).to_not have_content '最初のタスク'
       end

    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it 'ユーザーAが作成したタスクの詳細が表示されること' do
        expect(page).to have_content '最初のタスク'
      end
    end

  end

  describe '詳細画面での削除機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it 'ユーザーAが作成したタスクが削除されること' do
        page.accept_confirm 'タスク「最初のタスク」を削除します。よろしいですか？' do
          click_link '削除'
        end
        within '.alert' do
          expect(page).to have_content "タスク「最初のタスク」を削除しました。"
        end
      end
    end

  end
end