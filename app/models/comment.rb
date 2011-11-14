# encoding: utf-8
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  validates :content, :presence => true
end
