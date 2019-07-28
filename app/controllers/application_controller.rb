class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def import
    Yuuvis::Data.new.push_data params.to_h[:data]
    puts "--------IMPORTED  COUNT : #{params.to_h[:data].size}"
    render json: {success: true}
  end

  def convert
    resp = Faraday.get(params[:url])
    data = JSON.parse(resp.body).dig("feed", "entry")
    array = data.each_with_object([]) do |json, array|
      array << {
        author: json.dig("author", "name","label"),
        version: json.dig("im:version", "label"),
        rating: json.dig("im:rating", "label"),
        title: json.dig("title", "label"),
        text: json.dig("content", "label"),
      }
    end
    resp = Faraday.post do |req|
      req.url "https://19a4e14c.ngrok.io/yuvis/v1/translate"
      req.headers['Content-Type'] = 'application/json'
      req.body = array.to_json
    end
    render json: {data: array, resp: JSON.parse(resp.body)}
  end
end
