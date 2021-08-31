# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :memo, presence: true
  
  mount_uploader :picture, PictureUploader
end
