module SystemHelper
  def login_user(user)
    visit "/login_as/#{ user.id }"
  end
end
