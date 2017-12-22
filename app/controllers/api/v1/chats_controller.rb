class Api::V1::ChatsController < ActionController::API

  def show
    #Find Users in Chat to be created or found
    id = params[:id].to_i
    @user = User.find(id)
    @current_friend = User.all.find_by_username(params[:a])

    #Find chats in common
    @common_chat = Chat.find_common_chat(@user, @current_friend)

    #create chat if none exists
    if @common_chat.empty?
      @common_chat = Chat.create_chat(@common_chat,@user, @current_friend )
    end

    #GENERATE MESSAGE ARRAY FOR FRONT END
    message_array = Chat.create_message_array(@common_chat)

    #CHAT ID
    chat_id = @common_chat.first.id

    #Sentiment Analysis Metrics to be sent to the Front End
    friend_sentiment_this_chat = Chat.user_sentiment_in_chat(@current_friend, @common_chat )
    my_sentiment_this_chat = Chat.user_sentiment_in_chat(@user,@common_chat )
    friend_sentiment_overall = Chat.user_overall_sentiment(@current_friend)
    my_sentiment_overall = Chat.user_overall_sentiment(@user)

    render json: {chat_messages: message_array, chat_id: chat_id, friend_sentiment_this_chat: friend_sentiment_this_chat, my_sentiment_this_chat: my_sentiment_this_chat, friend_sentiment_overall: friend_sentiment_overall, my_sentiment_overall: my_sentiment_overall}
  end

end
