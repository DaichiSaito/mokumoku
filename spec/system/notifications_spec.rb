require 'rails_helper'

describe 'お知らせ機能', type: :system do

  # 以下、通知が行くタイミング
  # よく行くエリアの投稿があった時
  # 自分のもくもくに誰かがコメントした時
  # 自分のもくもくに誰かが参加した時
  # 自分が参加予定のもくもくにコメントがあった時

  # よく行くエリアが渋谷・目黒・世田谷エリアのユーザA
  let!(:user_a) { create(:user, :with_favorite_areas, name: 'ユーザーA', favorite_area_id: 1) }
  # よく行くエリアが新宿・中野・杉並・吉祥寺エリアのユーザB
  let!(:user_b) { create(:user, :with_favorite_areas, name: 'ユーザーB', favorite_area_id: 2) }
  # よく行くエリアが六本木・麻布・赤坂・青山エリアのユーザB
  let!(:user_c) { create(:user, :with_favorite_areas, name: 'ユーザーC', favorite_area_id: 3) }

  describe 'もくもくの投稿' do
    it '通知が来ること/来ないこと' do
      # ユーザAでもくもくを作る
      login_user(user_a)
      visit new_mypage_mokumoku_path
      fill_in 'タイトル', with: 'タイトルです'
      fill_in '詳細', with: '本文です'
      find('#mokumoku_open_at').click
      click_link '30'
      find('#th-6').click
      find('#tm-30').click

      select '新宿・中野・杉並・吉祥寺', from: 'mokumoku_area_id'

      click_button '登録'
      expect(page).to have_content 'もくもくを作成しました。'

      # ユーザA（自分）には通知が行かない
      click_link 'button_notification'
      expect(page).not_to have_content "#{user_a.name}が新宿・中野・杉並・吉祥寺エリアのもくもくを公開しました。"

      # ユーザBには通知が行く
      login_user(user_b)
      visit root_path
      click_link 'button_notification'
      expect(page).to have_content "#{user_a.name}が新宿・中野・杉並・吉祥寺エリアのもくもくを公開しました。"

      # ユーザCには通知が行かない
      login_user(user_c)
      visit root_path
      click_link 'button_notification'
      expect(page).not_to have_content "#{user_a.name}が新宿・中野・杉並・吉祥寺エリアのもくもくを公開しました。"
    end
  end

  describe 'もくもくへのコメント' do
    it '通知が来ること' do
      # ユーザAでもくもくを作る
      login_user(user_a)
      visit new_mypage_mokumoku_path
      fill_in 'タイトル', with: 'タイトルです'
      fill_in '詳細', with: '本文です'
      find('#mokumoku_open_at').click
      click_link '30'
      find('#th-6').click
      find('#tm-30').click
      select '新宿・中野・杉並・吉祥寺', from: 'mokumoku_area_id'

      click_button '登録'
      expect(page).to have_content 'もくもくを作成しました。'

      # ユーザBでコメントする
      login_user(user_b)
      visit mokumoku_path(user_a.mokumokus.first)

      fill_in 'コメント', with: 'コメントだよ'
      click_button '投稿'
      expect(page).to have_content 'コメントだよ'

      # ユーザAに通知がいく
      login_user(user_a)
      visit root_path
      click_link 'button_notification'
      expect(page).to have_content "#{user_b.name}があなたのもくもくにコメントしました。"
    end
  end

  describe 'もくもくへの参加' do
    it '通知が来ること' do
      # ユーザAでもくもくを作る
      login_user(user_a)
      visit new_mypage_mokumoku_path
      fill_in 'タイトル', with: 'タイトルです'
      fill_in '詳細', with: '本文です'
      find('#mokumoku_open_at').click
      click_link '30'
      find('#th-6').click
      find('#tm-30').click
      select '新宿・中野・杉並・吉祥寺', from: 'mokumoku_area_id'

      click_button '登録'
      expect(page).to have_content 'もくもくを作成しました。'

      # ユーザBが参加する
      login_user(user_b)
      visit mokumoku_path(user_a.mokumokus.first)

      click_link '参加する！'

      # ユーザAに通知がいく
      login_user(user_a)
      visit root_path
      click_link 'button_notification'
      expect(page).to have_content "#{user_b.name}があなたのもくもくに参加しました。"
    end
  end

  describe '自分の参加予定のもくもくへのコメント' do
    it '通知が来ること/来ないこと' do
      # ユーザAでもくもくを作る
      login_user(user_a)
      visit new_mypage_mokumoku_path
      fill_in 'タイトル', with: 'タイトルです'
      fill_in '詳細', with: '本文です'
      find('#mokumoku_open_at').click
      click_link '30'
      find('#th-6').click
      find('#tm-30').click
      select '新宿・中野・杉並・吉祥寺', from: 'mokumoku_area_id'

      click_button '登録'
      expect(page).to have_content 'もくもくを作成しました。'

      # ユーザBが参加する
      login_user(user_b)
      visit mokumoku_path(user_a.mokumokus.first)

      click_link '参加する！'

      fill_in 'コメント', with: '参加しまーす。'
      click_button '投稿'
      expect(page).to have_content '参加しまーす。'

      # ユーザCがコメントする
      login_user(user_c)
      visit mokumoku_path(user_a.mokumokus.first)

      fill_in 'コメント', with: '19:00以降もやってますか？？'
      click_button '投稿'

      # ユーザBに通知がいく
      login_user(user_b)
      visit root_path

      click_link 'button_notification'
      expect(page).to have_content "#{user_c.name}があなたが参加予定のもくもくにコメントしました。"
    end
  end
end
