class ChatroomsController < ApplicationController

  def show
    @message = Message.new
    @messages =Message.most_recent
  end

end