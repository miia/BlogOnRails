class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy #when a Post is deleted, we want all Comments associated with it to be deleted as well.
end
