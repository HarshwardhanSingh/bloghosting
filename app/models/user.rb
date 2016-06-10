class User < ActiveRecord::Base
  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

        has_many :posts
        has_many :comments
        has_many :notifications
        belongs_to :profession
        has_and_belongs_to_many :interests
        acts_as_liker
        acts_as_voter
        acts_as_followable
        acts_as_follower
        has_attached_file :avatar, :styles => { :large => "128x128#",:medium => "73x73#",:small => "48x48#" ,:thumb => "24x24#" }, :default_url => "/images/:style/default.jpg"
        validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

        def self.find_for_database_authentication(warden_conditions)
          conditions = warden_conditions.dup
          if login = conditions.delete(:login)
            where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
          else
            where(conditions.to_h).first
          end
        end
end
