class Chat < ApplicationRecord
  has_many :messages
  has_many :chats_users
  has_many :users, through: :chats_users

end
