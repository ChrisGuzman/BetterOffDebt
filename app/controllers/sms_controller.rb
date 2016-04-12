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
    begin
      msg = params["Body"]
      name = msg[/@(.*?) /].strip.gsub("@", "")
      munny = Monetize.parse(msg).to_f

      b = Balance.find_or_create_by(name: name)
      b.update(amount: b.amount.to_f + munny)

      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Got it. The balance for #{b.name} is now #{b.amount}"
      end
    rescue => ex
      Rails.logger.error ex.message
      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Sorry! I didn't understand that. Try texting '@chris owes 10'"
      end
    end
    render plain: twiml.text
  end
end
