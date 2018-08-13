class AdminMailer < ApplicationMailer
  def report(vendor, visitor, flat, booking)
    @booking = booking
    @vendor = vendor
    @visitor = visitor
    @flat = flat

    mail to: 'admin@gmail.com', subject: "Report from FlatBooking #{Date.today}"
  end
end
