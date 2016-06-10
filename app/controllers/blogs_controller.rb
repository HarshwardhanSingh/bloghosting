class BlogsController < ApplicationController
  include ActionView::Helpers::UrlHelper
  before_action :authenticate_user!, except: [:show,:index]

  def index
    # Display Most Popular Blogs
  end

  def show
    @blog = Blog.where('link == ?',params[:link]).first
    if @blog.nil?
      redirect_to root_path, :notice => 'BLOG NOT FOUND'
    else
      @articles = Article.where("blog_id == ?",@blog.id)
    end
  end

  def new
    @blog = Blog.new
  end

  # def blogSuggestions
  #   @blogs = []
  #   @communities = []
    
  #   @blogs = Blog.where('community_id')
  # end

  def fetchArticles
    @blog = Blog.where('name == ?',params[:link])
    @articles = Article.where('blog_id == ?',@blog.id).where('').order(created_at: :desc).limit(2)
    respond_to do |format|
      format.js
    end
  end

  def checkUniqueLink
    @link = Blog.where('link == ?',params[:link]).first
    if /\W/.match(params[:link]).nil?
      if @link.nil?
        respond_to do |format|
          format.html{redirect_to :back}
          format.js{@data = 'Link available'}
        end
      else
        respond_to do |format|
          format.html{redirect_to :back}
          format.js{@data = 'Not available'}
        end
      end
    else
      respond_to do |format|
        format.html{redirect_to :back}
        format.js{@data = 'Only Characters and Numbers'}
      end
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      respond_to do |format|
        format.html{redirect_to blog_path(@blog)}
        format.js{}
      end
    else
      render 'new'
    end
  end

  def edit
    @blog = Blog.find(params[:id])
    if @blog
      if @blog.user_id != current_user.id
        redirect_to :back, :notice => "Unauthorized Action"
      end
    end
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog
      if @blog.user_id != current_user.id
        redirect_to :back, :notice => "Unauthorized Action"
      else
        @blog.update(blog_params)
        respond_to do |format|
          format.html{ redirect_to blog_path(@blog)}
          format.js
        end
      end
    end
  end

  def updateAvatar
    @blog = Blog.find(params[:id])
    if @blog
      @blog.update_attributes(avatar: params[:blog][:avatar])
      @blog.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @blog.user_id != current_user.id
      redirect_to :back, :notice => "Unauthorized Action"
    else
      @blog = Blog.find(params[:id])
      @blog.destroy
      respond_to do |format|
        format.html{redirect_to :back}
        format.js{}
      end
    end
  end

  def subscribe
    @blog = Blog.find(params[:id])
    if !@blog.nil?
      if !current_user.follows?(@blog)
        current_user.follow!(@blog)
        respond_to do |format|
          format.html{redirect_to :back}
          format.js{}
        end
      end
    end
  end

  def unsubscribe
    @blog = Blog.find(params[:id])
    if !@blog.nil?
      if current_user.follows?(@blog)
        current_user.unfollow!(@blog)
        respond_to do |format|
          format.html{redirect_to :back}
          format.js{}
        end
      end
    end
  end

  def getSubscribers
    @blog = Blog.where('link == ?',params[:link]).first
    if @blog
      @followers = Follow.where('followable_type == ?',"Blog").where('followable_id == ?',@blog.id).pluck('follower_id')
      if @followers
        @users ||=[]
        @followers.each do |follower|
          @users << User.find(follower)
        end
      end 
    end
  end

  # To Be moved to Seperate Controller

  def follow
    @user = User.find(params[:id])
    if !@user.nil?
      if !current_user.follows?(@user)
        current_user.follow!(@user)
        @notice = Notification.new
        @notice.user_id = @user.id
        @notice.notice = link_to current_user.username, sketchbook_path(username: current_user.username) "is following you"
        @notice.trigger_type = "Follow"
        @notice.trigger_user_id = current_user.id
        @notice.save!
        respond_to do |format|
          format.html{redirect_to :back}
          format.js {render layout: false}
        end
      end
    end
  end

  def unfollow
    @user = User.find(params[:id])
    if !@user.nil?
      if current_user.follows?(@user)
        current_user.unfollow!(@user)
        @notice = Notification.where(user_id: @user.id).where(trigger_type: "Follow").where(trigger_user_id: current_user.id).first
        if !@notice.nil? 
          @notice.destroy
        end
        respond_to do |format|
          format.html{redirect_to :back}
          format.js {render layout: false}
        end
      end
    end
  end



  private
    def blog_params
      params.require(:blog).permit(:name,:desc,:category_id,:link)
    end
end
