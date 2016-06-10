class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :set_article,except: [:new,:create]
	before_action :set_blog,only: [:new,:create]
	
	def show
	end
	
	def new
		@article = Article.new
	end

	def create
		if @blog.user_id == current_user.id
			@article = Article.new(article_params)
			@article.blog_id = @blog.id
			if @article.save
				respond_to do |format|
					format.html{redirect_to blog_path(@blog)}
				end
			else
				render 'new'
			end
		else
			redirect_to root_path,flash[:notice]=> "Unauthorized action"
		end
	end

	def edit
	end

	def update
	end

	def destroy
		if @article.blog.user.id = current_user.id
			@article.destroy
			respond_to do |format|
				format.html{redirect_to :back}
				format.js
			end
		end
	end

	def upvote
		@article.liked_by current_user
		respond_to do |format|
			format.html{ redirect_to :back }
			format.js{}
		end
	end

	def downvote
		@article.unliked_by current_user
		respond_to do |format|
			format.html{ redirect_to :back }
			format.js{}
		end
	end

	private
		def article_params
			params.require(:article).permit(:title,:content,:image)
		end

		def set_blog
			@blog = Blog.find(params[:blog_id])
		end

		def set_article
			@article = Article.find(params[:id])
		end
end
