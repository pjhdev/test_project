class SessionsController < ApplicationController
  def create
    member = from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = member.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def from_omniauth(auth)
    member = Member.where(provider: auth.provider, uid: auth.uid).first_or_initialize
    member.provider = auth.provider
    member.uid = auth.uid
    member.name = auth.info.name
    member.oauth_token = auth.credentials.token
    member.oauth_expires_at = Time.at(auth.credentials.expires_at)
    member.save
    return member
  end
end
