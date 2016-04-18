require 'twilio-ruby'

class SmsController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def create
    begin
      msg = params["Body"]

      names = msg.scan(/([@|#].*? )/).flatten
      raise "Twitter handles not parsed" unless names.length == 2
      munny = Monetize.parse(msg).to_f

      b = Balance.find_or_create_by(debtor: names[0].strip, debtee: names[1].strip)
      b.update(amount: b.amount.to_f + munny)

      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Got it. #{b.debtor} owes #{b.debtee} #{ActionController::Base.helpers.number_to_currency(b.amount)}"
      end
    rescue => ex
      Rails.logger.error ex.message
      twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Sorry! I didn't understand that. Try texting '@speaktochris owes @twitter 10'"
      end
    end
    render plain: twiml.text
  end
end
