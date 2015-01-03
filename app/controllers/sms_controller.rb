class UsersController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authencity_token


  def index
    response = Twilio:TwiML::Response.new do |r|
      r.

  end
end
