class ProofOfDelaysController < ApplicationController
  def new
    @delay_info = DelayInfo.new
    @maps_javascript_api_key = Rails.application.credentials.api_key[:maps_javascript_api]
  end

  def create
    # binding.pry
  end

  def show
  end
end
