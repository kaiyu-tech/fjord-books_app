# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @carol = users(:carol)
    @dave = users(:dave)
    @eve = users(:eve)

    @alice.follow(@carol)
  end

  test '#following?' do
    assert_not @alice.following?(@bob)

    @alice.follow(@bob)

    assert @alice.following?(@bob)
  end

  test '#followed_by?' do
    assert_not @alice.followed_by?(@bob)

    @bob.follow(@alice)

    assert @alice.followed_by?(@bob)
  end

  test '#follow' do
    assert_not Relationship.where(follower_id: @alice.id).where(following_id: @bob.id).exists?

    @alice.follow(@bob)

    assert Relationship.where(follower_id: @alice.id).where(following_id: @bob.id).exists?
  end

  test '#unfollow' do
    assert Relationship.where(follower_id: @alice.id).where(following_id: @carol.id).exists?

    @alice.unfollow(@carol)

    assert_not Relationship.where(follower_id: @alice.id).where(following_id: @carol.id).exists?
  end

  test '#name_or_email' do
    assert_equal 'eve@example.com', @eve.name_or_email

    @eve.name = 'eve'

    assert_equal 'eve', @eve.name_or_email
  end
end
