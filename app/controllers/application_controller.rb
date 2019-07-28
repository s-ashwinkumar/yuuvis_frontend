class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def import
    byebug
    render :json, {success: true}
  end
end
