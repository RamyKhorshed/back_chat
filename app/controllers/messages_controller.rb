class MessagesController < ApplicationController
  def create

   current_user = User.find_by_username(params[:username])
   current_chat = Chat.find(params[:chat])

   message = current_user.messages.build(message_params)
   current_chat.messages << message

   message.sentiment_score = Sentimentalizer.analyze(message.content).overall_probability
   if message.save
     ActionCable.server.broadcast "room_channel_#{current_chat.id}",
                                  content:  message.content,
                                  username: message.user.username,
                                  messagescore: message.sentiment_score
   end

   array = []
   current_user.messages.each {|message| array.push(message.sentiment_score)}
   my_average_sent_score= array.compact.sum/array.compact.size


 end

 private

 def message_params
   params.require(:message).permit(:content)
 end
end
