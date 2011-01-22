class TwitterAccount < ActiveRecord::Base
  enum_attr :status, %w(^pending active disabled invalid)
  has_many :tweets, :foreign_key => :account_id

  validates_presence_of :name
  validates_uniqueness_of :name

  named_scope :active, where(:status => :active)
end
