class Admin::TwitterAccountsController < Admin::BaseController
  def index
    @twitter_accounts = TwitterAccount.admin
  end

  def update
    @twitter_account = TwitterAccount.find(params[:id])
    @twitter_account.assign_attributes(params[:twitter_account], :as => :admin)
    unless @twitter_account.save
      flash_errors
    end
    redirect_to admin_twitter_accounts_url
  end

  def create
    @twitter_account = TwitterAccount.new(params[:twitter_account])
    @twitter_account.status = :active

    unless @twitter_account.save
      flash_errors
    end

    redirect_to :action => :index
  end
      
  def flash_errors
    flash[:error] = @twitter_account.errors.map{|k,v| [k,v].join(' ')}.join(', ')
  end
end
