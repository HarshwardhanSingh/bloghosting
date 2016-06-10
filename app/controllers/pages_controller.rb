class PagesController < ApplicationController
  # before_action :authenticate_user!,only: [:sketchbook]
  
  skip_before_filter :verify_authenticity_token, :only => :updateAvatar

  def index
    if user_signed_in?
      redirect_to dashboard_path
    end
  end

  def dashboard
    @f_users = Follow.where('followable_type == ?',"User").where('follower_id == ?', current_user.id).pluck('followable_id')
    @f_users << current_user.id
    @posts = Post.having(user_id: @f_users).group('id').order(id: :desc).limit(1)
    @f_blogs = Follow.where('followable_type == ?',"Blog").where('follower_id == ?', current_user.id).pluck('followable_id')
    @articles = Article.having(blog_id: @f_blogs).group('id')
  end

  def explore
    if !params[:q].nil?
      @q = User.ransack(params[:q])
      @users = @q.result
    elsif params[:q].nil?
      @users = nil
    end
  end

  def lala
    @q = User.ransack(params[:q])
    @users = @q.result
    render 'explore'
  end

  def checkData
    @link = Blog.where('link == ?',params[:link]).first
    @para = params[:link]
    @result = /[[:alpha:]]/.match(@para)
    if !@result.nil?
      if @link.nil?
        @message = 'Link available'
        respond_to do |format|
          format.html{redirect_to :back}
          format.js{}
        end
      else
        @message = 'Not available'
        respond_to do |format|
          format.html{redirect_to :back}
          format.js{}
        end
      end
    else
      @message = 'Only Characters and Numbers'
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    end
    # @data = Blog.where('link == ?',params[:blog_link]).first
    # if !@data.nil?
    #   @message = "Link not available"
    #   respond_to do |format|
    #     format.js
    #   end
    # else
    #   @message = "Link is available"
    #   respond_to do |format|
    #     format.js
    #   end
    # end
  end

  def checkUsername
    @data = User.where('username == ?',params[:username]).first
    if !@data.nil?
      @message = "Username not available"
      respond_to do |format|
        format.js
      end
    else
      @message = "Username is available"
      respond_to do |format|
        format.js
      end
    end
  end

  def checkNotification
    @posts = Post.all
    @count = User.where('last_sign_in_at < ?', 10.minutes.ago).count 
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  def sketchbook
    @user = User.find_by(username: params[:username])
    if !@user.nil?
      @posts = Post.where('user_id == ?',@user.id).order(created_at: :desc)
      @posts.each do |post|
        @comment = post.comments.build
      end
    end
  end

  def fetch
    if params[:profilePost]
      @user = User.where('username == ?',params[:username]).first
      @posts = Post.where('user_id == ?',@user.id).where('id < ?',params[:profilePost]).order(created_at: :desc).limit(2)
      @posts.each do |post|
        @comment = post.comments.build
      end
      respond_to do |format|
        format.js
      end
    elsif params[:dashPost]
      @f_users = Follow.where('followable_type == ?',"User").where('follower_id == ?', current_user.id).pluck('followable_id')
      @f_users << current_user.id
      @posts = Post.having(user_id: @f_users).group('id').where('id < ?',params[:dashPost]).order(created_at: :desc).first
      # @comment = @posts.comments.build
      respond_to do |format|
        format.js
      end
    end
  end

  def updateAvatar
    @user = User.where('username == ?', current_user.username).first
    @user.update_attributes(avatar: params[:user][:avatar])
    @user.save
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js{}
    end
  end 

  def followings
    @user = User.where('username == ?',params[:username]).first
    if !@user.nil?
      @followings = Follow.where('follower_id == ?',@user.id).where(followable_type: "User").pluck('followable_id')
      @users = []
      @followings.each do |following|
        @users << User.find(following)
      end
    end
  end

  def followers
    @user = User.where('username == ?',params[:username]).first
    if !@user.nil?
      @followers = Follow.where('followable_id == ?',@user.id).where('followable_type == ?',"User").pluck('follower_id')
      @users = []
      @followers.each do |follower|
        @users << User.find(follower)
      end
    end
  end

  def userCard
    @user = User.where('username == ?',params[:username]).first
    if !@user.nil?
      @posts = Post.where('user_id == ?',@user.id).order(created_at: :desc)
    end
  end


end


# Ajax comment load
#Ajax search
# Fix auto load
# Add gem auto link
# Add feature to control panel
# Add colourful animations to index page
# Prepare text
# Fix acts_as_votable
# Fix Post ranking algo
# Create notification on follow