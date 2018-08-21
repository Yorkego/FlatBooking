class Flat < ApplicationRecord
  has_attached_file :image, styles: { large: "800x800>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  belongs_to :user
  has_many :bookings

  paginates_per 5

  validates :name, :city, :address, :description, :capacity, :price, presence: true
end
