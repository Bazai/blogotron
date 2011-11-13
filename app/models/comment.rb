# encoding: utf-8
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  validates_presence_of :content, :on => :create, :message => "Комментарий не может быть пустым"
end
