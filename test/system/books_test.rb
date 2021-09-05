# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    travel_to('2021-06-01 12:00:00 +0900')

    @book1 = books(:book1)
    @book2 = books(:book2)

    @alice = users(:alice)
  end

  test 'visiting the index' do
    log_in_as(@alice)

    visit books_url

    assert_selector 'h1', text: '本'
  end

  test 'showing the books' do
    log_in_as(@alice)

    visit book_url(@book1)

    assert_selector 'h1', text: '本の詳細'

    assert_text @book1.title
    assert_text @book1.memo
    assert_text @book1.author
  end

  test 'creating a book' do
    log_in_as(@alice)

    visit books_url

    click_on '新規作成'

    fill_in 'タイトル', with: @book1.title
    fill_in 'メモ', with: @book1.memo
    fill_in '著者', with: @book1.author

    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text @book1.title
    assert_text @book1.memo
    assert_text @book1.author

    click_on '戻る'
  end

  test 'updating a book' do
    log_in_as(@alice)

    visit books_url

    find("a[href='/books/#{@book1.id}/edit']").click

    fill_in 'タイトル', with: "[WIP] - #{@book1.title}"

    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text "[WIP] - #{@book1.title}"

    click_on '戻る'
  end

  test 'destroying a book' do
    log_in_as(@alice)

    visit books_url

    page.accept_confirm do
      find("a[href='/books/#{@book1.id}'][data-method=delete]").click
    end

    assert_text '本が削除されました。'
  end

  test 'commenting the book' do
    log_in_as(@alice)

    visit book_url(@book1)

    assert_text '（コメントがありません）'

    fill_in 'comment_content', with: '初心者にお勧めしたい本です！'

    click_on 'コメントする'

    assert_text '初心者にお勧めしたい本です！'
    assert_text @alice.name
    assert_text '06/01 12:00'
  end
end
