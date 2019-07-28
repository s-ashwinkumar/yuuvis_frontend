class DashboardController < ApplicationController
  def index

  end

  def get_chart_data
    chart_data = Yuuvis::Data.new.dashboard_charts
    render json: {
      chart1: chart_data[:chart1][:data].map(&:last),
      chart2: {
        positives: chart_data[:chart2][:positives].values.reverse,
        negatives: chart_data[:chart2][:negatives].values.reverse,
        keys: chart_data[:chart2][:positives].keys.reverse
      },
      cloud_entries: chart_data[:entries]
    }
  end
end
