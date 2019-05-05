class LoginController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def login
    email = params[:login][:email]
    passwd = params[:login][:password]

    user = User.find_by(email: email)
    respond_to do |format|
      Rails.logger.info(passwd)
      Rails.logger.info(user.password_digest)
      if user.authenticate(passwd)
        session[:user_id] = user.id
        format.html { redirect_to bulletin_posts_path(Bulletins::GALLERY) }
      else
        format.html { redirect_to login_path, alert: 'password not matched' }
      end
    end
  end
end
