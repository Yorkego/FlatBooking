class BookingService

  def initialize(booking)
      @booking = booking
  end

  def add_reserved_date
    (@booking.start_date..@booking.end_date).each do |date|
      # byebug
      @booking.flat.reserved_date.push(date)
      @booking.flat.save
    end
  end

  def remove_reserved_date
    (@booking.start_date..@booking.end_date).each do |date|
      # byebug
      @booking.flat.reserved_date.delete(date)
      @booking.flat.save
    end
  end
end
