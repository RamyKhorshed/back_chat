class User < ApplicationRecord
  has_many :messages
  has_many :watson_insights
  has_many :chats_users
  has_many :chats, through: :chats_users
  has_secure_password

  def all_conversations
    messages = self.messages
    array = []
    messages.each {|message| array.push(message.content)}
    array.join(" ")
  end

end
