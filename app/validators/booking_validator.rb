class BookingValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date.present? && record.end_date.nil?
      record.end_date = record.start_date
    end
    if record.start_date.present? && record.end_date.present?
      (record.start_date..record.end_date).each do |date|
        if record.flat.reserved_date.include?(date)
          record.errors.add :base, "#{date} is already reserved"
        end
      end
    end
  end
end
