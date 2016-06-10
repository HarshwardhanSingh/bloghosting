class Profession < ActiveRecord::Base
	has_many :users
	belongs_to :category
end
