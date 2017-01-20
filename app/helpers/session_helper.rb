helpers do
  def session_user_id
    session[:user_id]
  end

  def session_user
    User.find_by_id(session_user_id)
  end

  def session_logout
    session[:user_id] = nil
  end

  def session_login(user_id)
    session[:user_id] = user_id
  end
end
