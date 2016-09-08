class Band < ActiveRecord::Base

  validates :name, presence: true
  
  has_many(
    :albums,
    class_name: 'Album',
    primary_key: :id,
    foreign_key: :band_id,
    dependent: :destroy
  )
end
