class UsersController < ApplicationController
  before_filter :require_user, :only => [:edit, :update]

  def map
    @cities = City.for_map
  end

  def poll
    @user = current_user || User.new
  end

  def process_poll
    @user = current_user || User.new
    if @user.update_attributes(params[:user])
      @new_user = session[:user_id].blank?
      session[:user_id] ||= @user.id
    else
      render :action => 'poll'
    end
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
