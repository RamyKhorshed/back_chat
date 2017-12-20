class RoomChannel < ApplicationCable::Channel
  def subscribed
    id = params[:chat_key]
    stream_from "room_channel_#{id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
