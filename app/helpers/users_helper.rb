# frozen_string_literal: true

module UsersHelper
  def display_name(user)
    user.name.present? ? user.name : user.email
  end
end
