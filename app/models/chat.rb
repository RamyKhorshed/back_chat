class Chat < ApplicationRecord
  has_many :messages
  has_many :chats_users
  has_many :users, through: :chats_users

  def self.find_common_chat(user1, user2)
    Chat.joins(:users).where(:users => {id:user1.id}).all & Chat.joins(:users).where(:users => {id:user2.id}).all
  end

  def self.create_message_array(chat)
    array = []
    chat_messages = chat.first.messages
    chat_messages.each {|message| array.push({content:message.content, username: message.user.username,messagescore: message.sentiment_score})}
    array
  end

  #create chat if none exists
  def self.create_chat(chat, user1, user2)
    chat = Chat.create({name:user1.username+user2.username})
    chat.users << user2 << user1
    chat = [chat]
  end

  #either a chat or a user
  def self.user_overall_sentiment(user)
    array =[]
    user.messages.all.each{|message| array.push(message.sentiment_score)}
    if array.compact.size == 0
      return 0
    end
    array.compact.sum/array.compact.size
  end

  def self.user_messages_in_chat(user, chat)
    chat.first.messages.all.where({user_id:user.id})
  end

  def self.message_sentiment(messages)
    array =[]
    messages.each{|message| array.push(message.sentiment_score)}
    if array.compact.size == 0
      return 0
    end
    array.compact.sum/array.compact.size
  end

  def self.user_sentiment_in_chat(user,chat)
    messages = user_messages_in_chat(user, chat)
    message_sentiment(messages.all)
  end

  def self.words_in_chat(user,chat)
    messages = user_messages_in_chat(user, chat)
    count = 0
    messages.each{|message| count += message.content.split.size}
    count
  end

  def self.update_words_in_chat(user,chat)
    messages = chat.messages.all.where({user_id:user.id})
    count = 0
    messages.each{|message| count += message.content.split.size}
    count
  end


end
