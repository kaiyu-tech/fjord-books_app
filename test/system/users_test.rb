# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase # rubocop:disable Metrics/ClassLength
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @carol = users(:carol)
    @dave = users(:dave)

    log_in_as(@carol)
    visit user_url(@dave)
    click_on 'フォローする'
    log_out
    log_in_as(@dave)
    visit user_url(@carol)
    click_on 'フォローする'
    log_out
  end

  test 'sign in' do
    visit root_url

    assert_text 'ログインもしくはアカウント登録してください。'

    fill_in 'Eメール', with: @alice.email
    fill_in 'パスワード', with: 'password'

    click_on 'ログイン'

    assert_text 'ログインしました。'
  end

  test 'sign out' do
    log_in_as(@alice)

    click_on 'ログアウト'

    assert_text 'ログアウトしました。'
  end

  test 'sign up' do
    visit new_user_registration_url

    fill_in 'Eメール', with: 'tokyo_tower@example.com'
    fill_in '氏名', with: '東京タワー'
    fill_in '郵便番号', with: '105-0011'
    fill_in '住所', with: '東京都港区芝公園4丁目2−8'
    fill_in '自己紹介文', with: '東京タワーは、日本の東京都港区芝公園にある総合電波塔の愛称である。'
    # fill_in 'ユーザー画像', with: 'password'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'

    click_on 'アカウント登録'

    assert_text 'アカウント登録が完了しました。'
  end

  test 'visiting the index' do
    log_in_as(@alice)

    visit users_url

    assert_selector 'h1', text: 'ユーザ'

    assert_text 'Eメール'
    assert_text '氏名'
    assert_text '郵便番号'
    assert_text '住所'
  end

  test 'showing the user' do
    log_in_as(@alice)

    visit user_url(@alice)

    assert_selector 'h1', text: 'ユーザの詳細'

    assert_text @alice.email
    assert_text @alice.name
    assert_text @alice.postal_code
    assert_text @alice.address
    assert_text @alice.self_introduction
  end

  test 'updating a user' do
    log_in_as(@alice)

    visit edit_user_registration_url

    fill_in '氏名', with: '通天閣'
    fill_in '郵便番号', with: '556-0002'
    fill_in '住所', with: '大阪府大阪市浪速区恵美須東1丁目18−6'
    fill_in '自己紹介文', with: '通天閣は、大阪府大阪市浪速区の新世界中心部に建つ展望塔である。'
    # fill_in 'ユーザー画像', with: 'password'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    fill_in '現在のパスワード', with: 'password'

    click_on '更新'

    assert_text 'アカウント情報を変更しました。'
    assert_text '通天閣'
    assert_text '556-0002'
    assert_text '大阪府大阪市浪速区恵美須東1丁目18−6'
    assert_text '通天閣は、大阪府大阪市浪速区の新世界中心部に建つ展望塔である。'
  end

  test 'destroying a user' do
    log_in_as(@alice)

    visit edit_user_registration_url

    page.accept_confirm do
      click_on 'アカウント削除'
    end

    assert_text 'アカウントを削除しました。またのご利用をお待ちしております。'
  end

  test 'following the user' do
    log_in_as(@alice)

    visit user_url(@bob)

    click_on 'フォローする'

    assert has_button?('フォロー解除する')
    assert_text '1 フォロワー'

    visit user_url(@alice)

    assert_text '1 フォロー'
  end

  test 'unfollowing the user' do
    log_in_as(@carol)

    visit user_url(@dave)

    click_on 'フォロー解除する'

    assert has_button?('フォローする')
    assert_text '0 フォロワー'

    visit user_url(@carol)

    assert_text '0 フォロー'
  end

  test 'showing the followings' do
    log_in_as(@carol)

    visit user_url(@carol)

    find("a[href='/users/#{@carol.id}/followings']").click

    assert_selector 'h1', text: 'フォロー'

    assert_text @dave.email
    assert_text @dave.name
    assert_text @dave.postal_code
    assert_text @dave.address
  end

  test 'showing the followers' do
    log_in_as(@carol)

    visit user_url(@carol)

    find("a[href='/users/#{@carol.id}/followers']").click

    assert_selector 'h1', text: 'フォロワー'

    assert_text @dave.email
    assert_text @dave.name
    assert_text @dave.postal_code
    assert_text @dave.address
  end
end
