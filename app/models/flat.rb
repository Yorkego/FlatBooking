class Flat < ApplicationRecord
  has_attached_file :image, styles: { large: "800x800>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  belongs_to :user
  has_many :bookings

  paginates_per 5

  validates :city, :address, :description, :capacity, presence: true

  scope :order_by, ->(category, direction) {
    case category
    when 'created_at'
      order("flats.created_at #{direction}")
    when 'price'
      order("flats.price #{direction}")
    end
   }

  def self.filter(params_filter)
    return @flats = Flat.all.order_by(category(params_filter), direction(params_filter)) unless params_filter.present?
    @flats = Flat.all
    @flats = @flats.where('name ILIKE ?', "%#{params_filter[:name]}%") if params_filter[:name].present?
    @flats = @flats.joins(:user).where(users: { name: params_filter[:vendor]}) if params_filter[:vendor].present?
    @flats = @flats.where( city: params_filter[:city] ) if params_filter[:city].present?
    if params_filter[:start_date].present? && params_filter[:end_date].present?
      date = (params_filter[:start_date]..params_filter[:end_date]).to_a
      # date = ['2018-08-15','2018-08-16']
      @flats = @flats.where.not( reserved_date: date )
    end
    @flats = @flats.order_by(params_filter[:category], params_filter[:direction])
    @flats
  end

  def self.category(params_filter)
    params_filter && params_filter[:category].present? ? params_filter[:category] : 'created_at'
  end

  def self.direction(params_filter)
    params_filter && params_filter[:direction].present? ? params_filter[:direction] : "ASC"
  end
end
