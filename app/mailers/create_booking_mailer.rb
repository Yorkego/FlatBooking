class CreateBookingMailer < ApplicationMailer
  def new_booking(booking)
    @booking = booking

    mail to: booking.flat.user.email, subject: "Your flat booked"
  end
end
