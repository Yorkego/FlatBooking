class DestoyBookingMailer < ApplicationMailer
  def delete_booking(booking, current_user)
    @booking = booking
    @current_user = current_user

    if current_user == @booking.user
      @user = @booking.flat.user
    elsif current_user == @booking.flat.user
      @user = @booking.user
    end

    mail to: @user.email, subject: "Booking cancel"
  end
end
