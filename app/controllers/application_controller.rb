class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def import
    Yuuvis::Data.new.push_data params[:data]
    render json: {success: true}
  end
end
