class Artist < ActiveRecord::Base

  has_many(
    :tracks,
    class_name: 'Track',
    primary_key: :id,
    foreign_key: :track_id,
    dependent: :destroy
  )
  belongs_to(
    :band,
    class_name: 'Band',
    primary_key: :id,
    foreign_key: :band_id
  )
end
