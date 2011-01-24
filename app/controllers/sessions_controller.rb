class SessionsController < ApplicationController
  def from_twitter
    auth = request.env["omniauth.auth"]
    twitter_account = TwitterAccount.find_by_twitterid(auth['uid']) || TwitterAccount.new(:name => auth['user_info']['nickname'])
    if twitter_account.new_record?
      twitter_account.twitterid = auth['uid']
      twitter_account.avatar_url = auth['user_info']['image']
    end

    if current_user
      # binding twitter account to user...
      if twitter_account.user
        flash[:error] = 'Этот Twitter-аккаунт уже привязан к другому пользователю. Если это ошибка, свяжись с разработчиком.'
      else
        twitter_account.user = current_user
        twitter_account.save!
        flash[:notice] = 'Twitter-аккаунт успешно добавлен.'
      end
      redirect_to edit_user_url
    else
      # authenticating...
      if twitter_account.new_record?
        user = User.create!(:provider => 'twitter', :name => auth['user_info']['name'], :email => auth['user_info']['email'])
        twitter_account.user = user
        twitter_account.save!
        redirect_to edit_user_url
      else
        redirect_to root_url
      end
      session[:user_id] = twitter_account.user_id
    end
  end

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
