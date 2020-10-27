class ProofOfDelaysController < ApplicationController
  def new
    @delay_info = DelayInfo.new
  end

  def create
    # binding.pry
  end

  def show
  end
end
