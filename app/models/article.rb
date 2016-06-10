class Article < ActiveRecord::Base
	belongs_to :blog
	has_many :comments,as: :commentable
	acts_as_votable
	has_attached_file :image, :styles => { :large => "500x500>",:medium => "400x400>",:small => "48x48#"}, :default_url => "/images/:style/default.jpg"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates :title,:content,presence: true
end
