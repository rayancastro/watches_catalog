class Api::V1::WatchesController < Api::V1::BaseController
  def index
    @watches = Watch.all

    render json: @watches, include: :discount_rule
  end
end
