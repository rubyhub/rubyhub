class SessionsController < ApplicationController
  def with_related_model
    auth = request.env["omniauth.auth"]

    human_name = auth['provider'].capitalize
    user_field = "#{auth['provider']}_account"
    model = user_field.classify.constantize

    account = model.find_by_uid(auth['uid']) || model.new(:name => auth['user_info']['nickname'])
    if account.new_record?
      account.uid = auth['uid']
      account.avatar_url = auth['user_info']['image']
    end

    if current_user
      # binding account to user...
      if account.user
        if account.user != current_user
          flash[:error] = "Этот #{human_name}-аккаунт уже привязан к другому пользователю. Если это ошибка, свяжись с разработчиком."
        end
      else
        account.user = current_user
        twitter_account.save!
        flash[:notice] = "#{human_name}-аккаунт успешно добавлен."
      end
      redirect_to edit_user_url
    else
      # authenticating...
      if account.new_record?
        user = User.create!(:provider => auth['provider'], :name => auth['user_info']['name'], :email => auth['user_info']['email'])
        account.user = user
        account.save!
        redirect_to edit_user_url
      else
        redirect_to root_url
      end
      session[:user_id] = account.user_id
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
