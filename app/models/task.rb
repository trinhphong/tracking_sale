class Task < ApplicationRecord
  belongs_to :admin
  belongs_to :user
  has_many   :taskoutlets
  has_many   :outlets, through: :taskoutlets

  geocoded_by latitude: :lat, longitude: :lon
  reverse_geocoded_by :latitude, :longitude
end
