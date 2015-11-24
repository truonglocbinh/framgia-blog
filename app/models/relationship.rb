# == Schema Information
#
# Table name: relationships
#
#  follower_id                   :integer 
#  followed_id		             :integer
#  
class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
