require 'twilio-ruby'

class TwilioController < ApplicationController

  after_filter :set_header

  def voice
  	response = Twilio::TwiML::Response.new do |r|
  	  r.Say 'Hi Bmore on Rails! Remember Han shot first.', :voice => 'man'
         r.Play 'http://linode.rabasa.com/cantina.mp3'
  	end

  	render text: response.text
  end

  private

  def set_header
      response.headers["Content-Type"] = "text/xml"
  end
end
