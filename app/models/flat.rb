class Flat < ApplicationRecord
  has_attached_file :image, styles: { large: "800x800>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  belongs_to :user
  has_many :bookings

  paginates_per 5

  validates :name, :city, :address, :description, :capacity, presence: true

  scope :order_by, ->(category, direction) {
    case category
    when 'created_at'
      order("flats.created_at #{direction}")
    when 'price'
      order("flats.price #{direction}")
    when 'capacity'
      order("flats.capacity #{direction}")
    when 'popularity'
      left_outer_joins(:bookings).order("bookings.count #{direction} NULLS LAST").group('flats.id')
    end
   }
end
