class NotificationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def notify
  	client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  	message  = client.account.messages.create from:'5104043328', to:ENV['MY_NUMBER'], body: 'Learning to send SMS you are.', media_url: 'http://linode.rabasa.com/yoda.gif'
  	render plain: message.status
  end

end