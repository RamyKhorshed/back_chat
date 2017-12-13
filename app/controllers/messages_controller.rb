class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
   current_user = User.find(1)
   message = current_user.messages.build(message_params)
   if message.save
     ActionCable.server.broadcast 'room_channel',
                                  content:  message.content,
                                  username: message.user.username
   end
 end

 private

 def message_params
   params.require(:message).permit(:content)
 end
end
