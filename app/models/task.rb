class Task < ApplicationRecord
  belongs_to :admin
  belongs_to :user

  geocoded_by latitude: :lat, longitude: :lon
  reverse_geocoded_by :latitude, :longitude
end
