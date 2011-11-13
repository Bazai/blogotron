# encoding: utf-8
class Post < ActiveRecord::Base
  attr_accessible :subject, :content, :user
  
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  validates :subject, :presence => true
  validates :content, :presence => true
  
  scope :ordered, :order => "updated_at ASC"
end
