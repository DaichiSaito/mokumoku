require 'rails_helper'

describe 'もくもく管理機能', type: :system do
  let(:user_a) { create(:user, name: 'ユーザーA', profile: 'ユーザーAのプロフィールだよ') }
  let(:user_b) { create(:user, name: 'ユーザーB', profile: 'ユーザーBのプロフィールだよ') }
  # 作成者がユーザーAであるもくもくを作成しておく
  let!(:mokumoku) { create(:mokumoku, title: '最初のもくもく', body: '最初のもくもくだよ！！', user: user_a) }
  describe '一覧表示機能' do
    it 'ユーザーAが作成したもくもくが表示される' do
      visit root_path
      within '#mokumoku_new_arrivals' do
        expect(find(".mokumoku-#{mokumoku.id}")).to have_content '最初のもくもく'
      end
    end
  end

  describe '詳細表示機能' do
    it 'ユーザーAが作成したもくもくの詳細が表示される' do
      visit mokumoku_path(mokumoku)
      within '.title' do
        expect(page).to have_content '最初のもくもく'
      end
      within '.body' do
        expect(page).to have_content '最初のもくもくだよ！！'
      end
      within '.open_at' do
        expect(page).to have_content mokumoku.open_at.to_s(:datetime)
      end
      within '.area' do
        expect(page).to have_content mokumoku.area.name
      end
      within '.attend_lists' do
        expect(page).to have_content 'まだ参加者はいません。'
      end
    end

    it 'ユーザーAのプロフィールが表示される' do
      visit mokumoku_path(mokumoku)
      within '.profile-box' do
        expect(page).to have_content 'ユーザーA'
        expect(page).to have_content 'ユーザーAのプロフィールだよ'
      end
    end
  end

  describe '投稿機能' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        visit new_mypage_mokumoku_path
        expect(current_path).to eq login_path
        expect(page).to have_content 'ログインしてください。'
      end
    end

    context 'ログインしている場合' do
      it '投稿ができること' do
        login_user(user_a)
        visit new_mypage_mokumoku_path
        fill_in 'タイトル', with: 'タイトルです'
        fill_in '詳細', with: '本文です'
        # DatePickerが立ち上がるためfill_inは使えなかった。
        # fill_in 'もくもく予定日時', with: Time.current.to_s(:datetime)
        find('#mokumoku_open_at').click

        # find('.dtp-select-day')last.clickとかにしたいけど動かなかった
        click_link '30'
        find('#th-6').click
        find('#tm-30').click

        select '渋谷・目黒・世田谷', from: 'mokumoku_area_id'

        click_button '登録'
        expect(current_path).to eq mypage_mokumoku_path(Mokumoku.last)
        expect(page).to have_content 'もくもくを作成しました。'
      end
    end
  end

  describe '編集機能' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        visit edit_mypage_mokumoku_path(mokumoku)
        expect(current_path).to eq login_path
        expect(page).to have_content 'ログインしてください。'
      end
    end

    context 'ログインしている場合' do
      it '更新ができること' do
        login_user(user_a)
        visit edit_mypage_mokumoku_path(mokumoku)
        fill_in 'タイトル', with: '編集後タイトルだよ'

        click_button '登録'
        expect(current_path).to eq mypage_root_path
        expect(page).to have_content 'もくもくを更新しました。'
      end
    end
  end
end
