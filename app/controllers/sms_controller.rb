require 'twilio-ruby'
 
class SmsController < ApplicationController
  include Webhookable
 
  after_filter :set_header
 
  skip_before_action :verify_authenticity_token
 
  def index
    sender = params[:From]
    friends = {
      "+14153334444" => "Curious George",
      "+14158157775" => "Boots",
      "+14155551234" => "Virgil",
      ENV['MY_NUMBER'] => "Guz"
    }
    name = friends[sender] || "Mobile Monkey"
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hello, #{name}. Thanks for the message."
    end

    render plain: twiml.text
  end

  def create
    msg = params["Body"].split("owes")
    if msg.length == 2 && msg[1].to_f != 0
      b = Balance.find_or_create_by(name: msg[0].strip)
      b.update(amount: b.amount.to_f + msg[1].to_f)
      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Got it. #{b.name} now owes #{b.amount}"
      end
    else
      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Sorry! I didn't understand that. Try texting 'Chris owes 10'"
      end
    end
    render plain: twiml.text
  end
end