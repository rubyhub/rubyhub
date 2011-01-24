class UsersController < ApplicationController
  before_filter :require_user, :only => [:edit, :update]

  def map
    @cities = City.for_map
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to :root, :notice => 'Профиль сохранен'
    else
      render :action => 'edit'
    end
  end

end
