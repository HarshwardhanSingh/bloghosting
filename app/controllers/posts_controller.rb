class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post,except: [:index,:new,:create]

  def index
    @posts = Post.all.order(created_at: :desc)
    @posts.each do |post|
      @comment = post.comments.build
    end
  end

  def show
    @comment = @post.comments.build
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    votes=0
    time=Time.now
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    votes = @post.likers(User).count
    time == @post.created_at
    @post.popularity = calc_popularity(votes,time)
    if @post.save
      respond_to do |format|
        format.html{redirect_to post_path(@post)}
        format.js{}
      end
    else
      render 'new'
    end
  end

  def edit
    if @post.user_id != current_user.id
      redirect_to root_path, :notice=> 'Unauthorized attempt'
    end
  end

  def update
    if @post.user_id != current_user.id
      redirect_to root_path, :notice=> 'Unauthorized attempt'
    else
      @post.update(post_params)
      @post.save
      respond_to do |format|
        format.html{redirect_to post_path(@post)}
        format.js{}
      end
    end
  end

  def destroy
    if @post.user_id != current_user.id
      redirect_to root_path, :notice=> 'Unauthorized attempt'
    else
      @post.destroy
      respond_to do |format|
        format.html{redirect_to posts_path}
        format.js{}
      end
    end
  end

  def like
    if !@post.liked_by?(current_user)
      current_user.like!(@post)
      # CReate notice after LIKE
      if current_user.id != @post.user_id
        @notification = Notification.where('post_id == ?',@post.id).where('trigger_type == ?',"Like").where('trigger_user_id',current_user.id)  
        if @notification.blank?
          @notice = Notification.new
          @notice.notice = "#{current_user.username} likes this Post '#{@post.content.truncate(10)}'"
          @notice.user_id = @post.user_id
          @notice.post_id = @post.id
          @notice.trigger_type = "Like"
          @notice.trigger_user_id = current_user.id
          @notice.save!
        end
      end
      # Notice Saved
      respond_to do |format|
        format.html{redirect_to :back}
        format.js{}
      end
    else
      respond_to do |format|
        format.html{redirect_to :back,:notice=> 'Unauthorized Action'}
        format.js{}
      end
    end
  end

  def unlike
    if @post.liked_by?(current_user)
      current_user.unlike!(@post)
      if current_user.id != @post.user_id
        @notification = Notification.where('post_id == ?',@post.id).where('trigger_type == ?',"Like").where('trigger_user_id',current_user.id).first
        if !@notification.blank?
          @notification.destroy
        end
      end  
      respond_to do |format|
        format.html{redirect_to :back}
        format.js{}
      end
    else
      respond_to do |format|
        format.html{redirect_to :back,:notice=> 'Unauthorized Action'}
        format.js{}
      end
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title,:content,:image)
    end
end
