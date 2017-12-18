class MessagesController < ApplicationController
  def create
  byebug
   current_user = User.find_by_username(params[:username])
   message = current_user.messages.build(message_params)
   message.sentiment_score = Sentimentalizer.analyze(message.content).overall_probability
   if message.save
     ActionCable.server.broadcast 'room_channel',
                                  content:  message.content,
                                  username: message.user.username,
                                  messagescore: message.sentiment_score
   end

   array = []
   current_user.messages.each {|message| array.push(message.sentiment_score)}
   my_average_sent_score= array.sum / array.size


 end

 private

 def message_params
   params.require(:message).permit(:content)
 end
end
