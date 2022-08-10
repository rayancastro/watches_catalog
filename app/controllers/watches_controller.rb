class WatchesController < ApplicationController
  def index
    @watches = Watch.all

    render json: @watches, include: :discount_rule
  end
end
