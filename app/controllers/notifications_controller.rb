class NotificationsController < ApplicationController
	before_action :authenticate_user!

	def notifications
		@notifications = Notification.where('user_id == ?',current_user.id).order(created_at: :desc)
		@notifications.each do |notice|
			notice.unread = 0
			notice.save
		end
	end

	def checkCounter
		@notifications = Notification.where('user_id == ?',current_user.id).where('unread == ?','1')
		@Ncounter = @notifications.count
		respond_to do |format|
			format.js
		end
	end

	def destroy
		@notification = Notification.find(params[:id])
		if @notification.user.id == current_user.id
			if !@notification.nil?
				@notification.destroy
				respond_to do |format|
					format.html{ redirect_to :back }
					format.js
				end
			end
		end
	end

end
