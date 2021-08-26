# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :active_follows, class_name: 'Follow',
                            foreign_key: 'follower_id',
                            dependent: :destroy,
                            inverse_of: :follower
  has_many :passive_follows, class_name: 'Follow',
                             foreign_key: 'followed_id',
                             dependent: :destroy,
                             inverse_of: :followed
  has_many :followings, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower

  def follow(other_user)
    followings << other_user
  end

  def unfollow(other_user)
    active_follows.find_by!(followed_id: other_user.id).destroy
  end

  def followings?(other_user)
    followings.include?(other_user)
  end
end
