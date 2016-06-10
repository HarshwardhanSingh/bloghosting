class CommentsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_post,only: [:create]
  
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    # Create notice for comment
    if @commentable.class == Post and current_user.id != @commentable.user_id
      @notice = Notification.new
      @notice.notice = "#{current_user.username} has commented on your post '#{@commentable.content}'"
      @notice.post_id = @commentable.id
      @notice.user_id = @commentable.user_id
      @notice.save
    end
    # Notice created for comment
    respond_to do |format|
      format.html{ redirect_to dashboard_path }
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.exists?
      @comment.destroy
      respond_to do |format|
        format.html{redirect_to :back}
        format.js{}
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end
end
