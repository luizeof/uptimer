require 'net/http'

class UptimeMonitorJob < ApplicationJob

  queue_as :default

  def perform(*args)
    begin
      uri = URI(Rails.configuration.monitor)
      res = Net::HTTP.get_response(uri)
      Uptime.create! code: res.code
    rescue
      Uptime.create! code: 0
    end
  end

end
