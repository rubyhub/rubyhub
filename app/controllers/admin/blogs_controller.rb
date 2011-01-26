class Admin::BlogsController < Admin::BaseController
  def index
    @users_with_new_blogs = User.where('url IS NOT NULL AND url!=""').all.select{|u| u.blog.blank?}
    @blogs = Blog.paginate(:page => params[:page])
  end

  def approve
  end

end
