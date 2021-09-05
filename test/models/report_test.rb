# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    travel_to('2021-06-01 12:00:00 +0900')

    @alice = users(:alice)

    @report1 = reports(:report1)
    @report2 = Report.create!(title: '[Day4] - Linux、Git & GitHub、Ruby',
                              content: '今日はRubyを初めて触りました。',
                              user: @alice)
  end

  test '#editable?' do
    assert @report1.editable?(@alice)
  end

  test '#created_on?' do
    assert_equal Date.parse('2021-06-01 12:00:00 +0900'), @report2.created_on
  end
end
