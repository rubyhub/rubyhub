class Tweet < ActiveRecord::Base
  belongs_to :account, :class_name => 'TwitterAccount'
end
