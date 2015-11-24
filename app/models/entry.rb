# == Schema Information
#
# Table name: entries
#
#  id                  :integer          not null, primary key
#  title			   :string
#  body 			   :text
#  user_id			   :integer
#
class Entry < ActiveRecord::Base
  belongs_to :user
  has_many   :comments
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 200 }
end
