class MessagesController < ApplicationController
  def create

   current_user = User.find_by_username(params[:username])
   current_chat = Chat.find(params[:chat])

   message = current_user.messages.build(message_params)
   current_chat.messages << message

   message.sentiment_score = Sentimentalizer.analyze(message.content).overall_probability
   my_sentiment_this_chat = Chat.user_sentiment_in_chat(current_user,[current_chat] )
   my_sentiment_overall = Chat.user_overall_sentiment(current_user)
   word_count = Chat.update_words_in_chat(current_user, current_chat)

   if message.save
     ActionCable.server.broadcast "room_channel_#{current_chat.id}",
                                  content:  message.content,
                                  username: message.user.username,
                                  messagescore: message.sentiment_score,
                                  my_sentiment_this_chat: my_sentiment_this_chat,
                                  my_sentiment_overall: my_sentiment_overall,
                                  word_count: word_count
   end

 end

 private

 def message_params
   params.require(:message).permit(:content)
 end
end
