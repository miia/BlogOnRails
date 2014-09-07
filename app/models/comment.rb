class Comment < ActiveRecord::Base
  belongs_to :post

  #additional Validations: every post must have a post_id (which links it to the corresponding post) and a body
  validates_presence_of :post_id
  validates_presence_of :body
end
