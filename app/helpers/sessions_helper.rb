module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    @current_user ||= get_current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def get_current_user
    user_id = session[:user_id]
    if user_id
      return User.find_by(id: user_id)
    else
      user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        return user
      end
    end
  end
end
