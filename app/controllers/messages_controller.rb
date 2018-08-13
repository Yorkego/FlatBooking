class MessagesController < ApplicationController
  def index
    @messages = Message.where(recipient: current_user.id)
  end

  def show
  end

  def new
    @message = Message.new
    if params[:recipient]
      @recipient = User.find(params[:recipient])
    end
  end

  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      @recipient = User.find(@message.recipient)
      MessageMailer.mail_message(@message, @recipient).deliver
      flash[:notice] = 'Message was successfully sended.'
      redirect_to root_url
    else
      flash[:alert] = "Message wasn't sended."
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :recipient)
  end
end
