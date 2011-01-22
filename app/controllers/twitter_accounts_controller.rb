class TwitterAccountsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @twitter_account = TwitterAccount.new(params[:twitter_account])
    if @twitter_account.save
      flash[:notice] = 'Аккаунт добавлен. Спасибо!'
    else
      flash[:error] = 'Не получилось добавить аккаунт'
    end
    
    redirect_to root_url
  end

end
