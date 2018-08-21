class BookingValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date.present? && record.end_date.nil?
      record.end_date = record.start_date
    end
    if record.start_date.present? && record.end_date.present?
      if record.start_date < Date.today
        record.errors.add :base, "Check in date can not be in the past"
      end
      if record.start_date > record.end_date
        record.errors.add :base, "Check out date can not be less than check in date"
      end
      if FlatsQuery.new.is_date_reserved?(record.start_date, record.end_date, record.flat.id)
        record.errors.add :base, "Your date is already reserved"
      end
    end
  end
end
