# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    travel_to('2021-06-01 12:00:00 +0900')

    @report1 = reports(:report1)
    @report2 = reports(:report2)

    @alice = users(:alice)
  end

  test 'visiting the index' do
    log_in_as(@alice)

    visit reports_url

    assert_selector 'h1', text: '日報'
  end

  test 'showing the report' do
    log_in_as(@alice)

    visit report_url(@report1)

    assert_selector 'h1', text: '日報の詳細'

    assert_text @report1.title
    assert_text @report1.content
  end

  test 'creating a report' do
    log_in_as(@alice)

    visit reports_url

    click_on '新規作成'

    fill_in 'タイトル', with: @report1.title
    fill_in '内容', with: @report1.content

    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text @report1.title
    assert_text @report1.content

    click_on '戻る'
  end

  test 'updating a report' do
    log_in_as(@alice)

    visit reports_url

    find("a[href='/reports/#{@report1.id}/edit']").click

    fill_in 'タイトル', with: "[WIP] - #{@report1.title}"

    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text "[WIP] - #{@report1.title}"

    click_on '戻る'
  end

  test 'destroying a report' do
    log_in_as(@alice)

    visit reports_url

    page.accept_confirm do
      find("a[href='/reports/#{@report1.id}'][data-method=delete]").click
    end

    assert_text '日報が削除されました。'
  end

  test 'commenting the report' do
    log_in_as(@alice)

    visit report_url(@report1)

    assert_text '（コメントがありません）'

    fill_in 'comment_content', with: 'わいわい一緒に頑張りましょう！'

    click_on 'コメントする'

    assert_text 'わいわい一緒に頑張りましょう！'
    assert_text @alice.name
    assert_text '06/01 12:00'
  end
end
