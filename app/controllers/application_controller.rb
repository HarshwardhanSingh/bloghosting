class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :set_search
  before_action :set_new_post, if: :user_signed_in?

  def calc_popularity(votes,time)
    s = votes
    order = Math.log10([s.abs, 1].max)
    if s > 0
      sign = 1  
    elsif s < 0 
      sign = -1
    else
      sign = 0
    end
    td = (time.to_time.to_i - Date.new(1970, 1, 1).to_time.to_i)
    td2 = td.days * 86400 + td.seconds + ((1000000*(td.seconds)).to_f)/1000000
    seconds = td2 - 1134028003
    @rank = (sign * order + seconds / 45000).round(7)
    return @rank
  end

  private
    def set_search
      @q=User.ransack(params[:q])
    end

    def set_new_post
      @post = Post.new
    end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email,:profession_id, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email,:profession_id,:about, :password, :password_confirmation, :current_password) }
  end

  


end
