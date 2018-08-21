class BookingSerializer < ActiveModel::Serializer
  attributes :title, :start, :end

  def title
    'reserved'
  end

  def start
    object.start_date
  end

  def end
    object.end_date + 1.day
  end
end
