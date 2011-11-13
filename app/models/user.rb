# encoding: utf-8
class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, :avatar, :avatar_cache, :remove_avatar
  
  # Связи
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  # def link_to_blog
  #   link_to email, blogs_path + "/" + id.to_s
  # end
  
  # def blog_url
  #     Rails.application.routes.url_helpers.blogs_path + "/" + id.to_s
  #   end
  
end