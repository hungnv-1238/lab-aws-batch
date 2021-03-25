class NasaImageRequestLog < ActiveRecord::Migration[6.1]
  def change
    create_table :nasa_image_request_logs do |t|
      t.text :url
      t.datetime :date_request
      t.text :description
      t.string :title
    end
  end
end
