class Blog < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :articles
  acts_as_followable
  has_attached_file :avatar, :styles => { :large => "128x128#",:medium => "73x73#",:small => "48x48#" ,:thumb => "24x24#" }, :default_url => "/images/:style/default.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :name,:desc,:link, presence: true
end
