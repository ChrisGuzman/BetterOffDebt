class User < ActiveRecord::Base
  has_many :balances
  has_secure_password
end
