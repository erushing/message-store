class Message < ActiveRecord::Base

  belongs_to :account
  belongs_to :channel

end