class LinkedInAccount < ActiveRecord::Base
  belongs_to :user

#  validates_presence_of :name

  attr_protected :uid, :avatar_url

  def url
    "http://www.linkedin.com/profile/view?id=#{uid}"
  end
end
