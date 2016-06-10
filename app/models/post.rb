class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, as: :commentable
	has_many :notifications
	acts_as_likeable
	has_attached_file :image, :styles => { :large => "500x500>",:medium => "400x400>",:small => "48x48#"}, :default_url => "/images/:style/default.jpg"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates :content, presence: true

	def self.updateRank
		@posts = Post.all
		@posts.each do |post|
			@rank = 0.00
			s = post.likers(User).count
			order = Math.log10([s.abs, 1].max)
			if s > 0
				sign = 1  
			elsif s < 0 
				sign = -1
			else
				sign = 0
			end
			td = (post.created_at.to_i - Date.new(1970, 1, 1).to_time.to_i)
			td2 = td.days * 86400 + td.seconds + ((1000000*(td.seconds)).to_f)/1000000
			seconds = td2 - 1134028003
			@rank = (sign * order + seconds / 45000).round(7)
			post.update_attributes(popularity: @rank)
			post.save
		end
	end

end
