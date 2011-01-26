class Admin::UsersController < Admin::BaseController
  def index
    @users = User.paginate(:page => params[:page])
  end

end
