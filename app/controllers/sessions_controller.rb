class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    if user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
      redirect_to root_url
    else
      user = User.create_with_omniauth(auth)
      redirect_to edit_user_url
    end
    session[:user_id] = user.id
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def failure
    redirect_to root_url, :error => 'Не удалось авторизоваться.'
  end
end
