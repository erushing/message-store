class Account < ActiveRecord::Base

  has_many :channels
  has_many :messages

end
