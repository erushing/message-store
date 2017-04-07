class Message < ActiveRecord::Base

  belongs_to :account
  belongs_to :channel

  has_many :labels
  has_many :activities
  has_many :attachments
  has_one :assignment

end
