class Members::MessagesController < Members::ApplicationController
  def my_message
    @message = Message.find(params[:message][:id])
  end

  def message
    @message = Message.find(params[:message][:id])
  end
end
