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

end
