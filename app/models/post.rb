class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy #when a Post is deleted, we want all Comments associated with it to be deleted as well.

  #additional Validations: every post must have a title and a body
  validates_presence_of :title
  validates_presence_of :body

end
