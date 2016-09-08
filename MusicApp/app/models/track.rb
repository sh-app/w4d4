class Track < ActiveRecord::Base

  validates :song, :album_id, :track_type, presence: true

  belongs_to(
    :album,
    class_name: 'Album',
    primary_key: :id,
    foreign_key: :album_id
  )
end
