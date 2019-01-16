
class DashboardController < ApplicationController

  def index
  end

  def stats
    render json: Uptime.recent.pluck(:created_at, :code)
  end

end
