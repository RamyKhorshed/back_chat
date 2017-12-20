class Api::V1::ChatsController < ActionController::API

  def show
    #Find Users in Chat to be created or found
    id = params[:id].to_i-1
    @user = User.all[id]
    @current_chat = User.all.find_by_username(params[:a])

    #Find chats in common
    @common_chat = Chat.joins(:users).where(:users => {id:@user.id}).all & Chat.joins(:users).where(:users => {id:@current_chat.id}).all


    #create chat if none exists
    if @common_chat.empty?
      @common_chat = Chat.create({name:@user.username+@current_chat.username})
      @common_chat.users << @current_chat << @user
      @common_chat = [@common_chat]
    end

    chat_messages = @common_chat.first.messages
    message_array=[]
    chat_messages.each {|message| message_array.push({content:message.content, username: message.user.username,messagescore: message.sentiment_score})}

    chat_id = @common_chat.first.id


    render json: {chat_messages: message_array, chat_id: chat_id}
  end

end
