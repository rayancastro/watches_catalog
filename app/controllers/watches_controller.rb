class WatchesController < ApplicationController
  def index
    @watches = Watch.all

    render json: @watches
  end
end
