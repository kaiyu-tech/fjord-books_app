# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  validates :user_id, presence: true
  mount_uploader :picture, PictureUploader
end
