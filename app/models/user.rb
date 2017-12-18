class User < ApplicationRecord
  has_many :messages
  has_many :chats_users
  has_many :chats, through: :chats_users
  has_secure_password
end
