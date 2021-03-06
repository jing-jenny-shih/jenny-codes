class MessagesController < ApplicationController
  def new
    @message = Message.new
    @page = {
      description: 'CONTACT'
    }
  end

  def create
    @message = Message.new message_params

    if @message.valid?
      MessageMailer.contact(@message).deliver_now
      redirect_to contact_url
      flash[:warning] = '收到!'
    else
      flash[:danger] = '出了點問題的樣子。再試一次？'
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :body)
  end

end
