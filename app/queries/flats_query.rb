class FlatsQuery
  attr_reader :relation

  def initialize(relation = Flat.all)
    @relation = relation
  end

  def filter(params_filter)
    return @relation = FlatsQuery.new(@relation).order_by(category(params_filter), direction(params_filter)) unless params_filter.present?
    @relation = @relation.where('name ILIKE ?', "%#{params_filter[:name]}%") if params_filter[:name].present?
    @relation = @relation.joins(:user).where(users: { name: params_filter[:vendor]}) if params_filter[:vendor].present?
    @relation = @relation.where( city: params_filter[:city] ) if params_filter[:city].present?
    @relation = @relation.where( capacity: params_filter[:capacity] ) if params_filter[:capacity].present?
    if params_filter[:start_date].present? && params_filter[:end_date].present?
      start_date = params_filter[:start_date].to_date
      end_date = params_filter[:end_date].to_date
      reserved_date(start_date, end_date)
    end
    @relation = FlatsQuery.new(@relation).order_by(params_filter[:category], params_filter[:direction])
    @relation
  end

  def reserved_date(start_date, end_date)
    query = @relation.joins(:bookings).where('(bookings.end_date >= :start_date AND bookings.end_date <= :end_date) OR
      (bookings.start_date >= :start_date AND bookings.start_date <= :end_date) OR
      (bookings.start_date <= :start_date AND bookings.end_date >= :end_date)',
       {start_date: start_date, end_date: end_date}).pluck('flats.id')

    @relation = @relation.where.not('flats.id IN (?)', query)
  end

  def is_date_reserved?(start_date, end_date, flat)
    query1 = Booking.where(flat_id: flat)
    query2 = query1.where('end_date >= ? AND end_date <= ?', start_date, end_date).or(
        query1.where('start_date >= ? AND start_date <= ?', start_date, end_date)
        ).or(query1.where('start_date <= ? AND end_date >= ?', start_date, end_date))
    if query2.count > 0
      return true
    else
      return false
    end
  end

  def reserved_date_array(flat)
    arr = []
    Booking.where(flat_id: flat).find_each do |book|
      returning_hash = {}
      returning_hash['title'] = 'reserved'
      returning_hash['start'] = book.start_date
      returning_hash['end'] = book.end_date + 1.day
      arr = arr.push(returning_hash)
    end
    return arr
  end

  def order_by(category, direction)
    case category
    when 'created_at'
      @relation.order("flats.created_at #{direction}")
    when 'price'
      @relation.order("flats.price #{direction}")
    when 'capacity'
      @relation.order("flats.capacity #{direction}")
    when 'popularity'
      @relation.left_outer_joins(:bookings).order("bookings.count #{direction} NULLS LAST").group('flats.id')
    end
  end

  private

  def category(params_filter)
    params_filter && params_filter[:category].present? ? params_filter[:category] : 'created_at'
  end

  def direction(params_filter)
    params_filter && params_filter[:direction].present? ? params_filter[:direction] : "ASC"
  end
end
