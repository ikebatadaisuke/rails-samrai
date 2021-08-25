class User < ApplicationRecord
  has_secure_password
 validates :name, presence: true, length: {maximum: 20}
 validates :email, presence: true, uniqueness: true, length: {maximum: 50}
 
 def posts
  return Post.where(user_id:self.id)
 end
end
