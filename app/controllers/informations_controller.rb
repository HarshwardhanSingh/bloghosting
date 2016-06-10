class InformationsController < ApplicationController
	before_action :authenticate_user!

	def bio
		@user = User.find(current_user.id)
	end

	def updateBio
		@user = User.find(current_user.id)
		@user.update_attribute(bio_params)
		@user.save
	end

	def avatar
		@user = User.find(current_user.id)
	end

	def updateAvatar
		@user = User.find(current_user.id)
		@user.update_attribute(params[:avatar])
		@user.save
	end

	def interests
		@user = User.find(current_user.id)
	end

	def updateInterests
	end

	def suggestions
	end

	private
		def bio_params
			params.require(:user).permit(:about)
		end

end
