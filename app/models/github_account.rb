class GithubAccount < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name

  attr_protected :uid, :avatar_url

  def url
    "https://github.com/#{name}"
  end
end
