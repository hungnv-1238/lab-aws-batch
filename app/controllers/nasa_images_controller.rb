class NasaImagesController < ApplicationController
  before_action :test_failed_action

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

  private
  def test_failed_action
    $fail_counter ||= 0

    $fail_counter += 1
    Rails.logger.info ">>>>> The counter now is #{$fail_counter}"
    render status: 500 if $fail_counter > 5
  end
end
