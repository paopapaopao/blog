module UserHelper
  def username(user)
    user.email.split("@")[0].capitalize
  end
end
