class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @message.chef = current_chef
    if @message.save
      #redirect_to chat_path
      ActionCable.server.broadcast 'chatroom_channel', message: render_message(@message), chef: @message.chef.chefname
    else
      render 'chatroomes/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    render(partial: 'message', locals: { message: message } )
  end
end