class MessagesController < ApplicationController

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # POST /messages or /messages.json
  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast("chatroom_channel", { mod_message: message_render(message) })
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body)
    end

    def message_render(message)
      render(partial: 'message', locals: {message: message})
    end
end
