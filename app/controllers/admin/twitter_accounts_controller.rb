class Admin::TwitterAccountsController < Admin::BaseController
  def index
    @twitter_accounts = TwitterAccount.all
  end

  def approve
    @twitter_account = TwitterAccount.find(params[:id])
    @twitter_account.status = :active
    @twitter_account.save!
    redirect_to admin_twitter_accounts_url
  end

  def create
    @twitter_account = TwitterAccount.new(params[:twitter_account])
    @twitter_account.status = :active

    unless @twitter_account.save
      flash[:error] = @twitter_account.errors.map{|k,v| [k,v].join(' ')}.join(', ')
    end

    redirect_to :action => :index
  end

end
