class Members::MessagesController < ApplicationController
  def my_message
    @message = Message.find(params[:message][:id])
  end

  def message
    @message = Message.find(params[:message][:id])
  end
end
