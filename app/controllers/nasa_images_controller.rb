class NasaImagesController < ApplicationController
  def show
    uri =  URI(Settings.nasa_image_endpoint +
      "?api_key=" + Settings.nasa_image_api_key +
      "&count=1")
    result = JSON.parse(Net::HTTP.get(uri)).first.symbolize_keys
    NasaImageRequestLog.create!(
      url: result[:url],
      date_request: Time.zone.now,
      description: result[:explanation],
      title: result[:title]
    )
    render json: {status: :success, data: result}
  rescue ActiveRecord::RecordInvalid => e
    render json: {status: :error, reason: e.errors.full_messages.first}
  rescue StandardError
    render json: {status: :error}
  end

  def index
    render json: NasaImageRequestLog.all.sample(10).as_json(only: :url)
  end

  def ping
    render json: {status: :pong}
  end
end
