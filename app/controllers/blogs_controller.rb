class BlogsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @blog = Blog.new(params[:blog])
    if @blog.save
      flash[:notice] = 'Блог добавлен. Спасибо!'
    else
      flash[:error] = 'Не получилось добавить блог'
    end
    
    redirect_to root_url
  end

end
