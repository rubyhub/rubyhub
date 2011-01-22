class Tweet < ActiveRecord::Base
  belongs_to :account, :class_name => 'TwitterAccount'

  named_scope :mainpage, order('published_at DESC').includes(:account).limit(20)
end
