class Album < ActiveRecord::Base

  validates :title, :band_id, :record_type, presence: true

  has_many(
    :tracks,
    class_name: 'Track',
    primary_key: :id,
    foreign_key: :album_id,
    dependent: :destroy
  )
  belongs_to(
    :band,
    class_name: 'Band',
    primary_key: :id,
    foreign_key: :band_id
  )
end
