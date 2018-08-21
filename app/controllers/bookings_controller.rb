class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def vedor_booking
    @bookings = Booking.joins(:flat).where(flats: { user_id: current_user.id })
  end

  def show
  end

  def new
    @booking = Booking.new
    @flat = Flat.find(params[:flat_id])
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    @booking.flat_id = params[:flat_id]

    if @booking.save
      CreateBookingMailer.new_booking(@booking).deliver unless @booking.flat.user == current_user

      flash[:notice] = "Book was successfully created."

      redirect_to root_url
    else
      flash[:alert] =  @booking.errors.full_messages
      redirect_to @booking.flat
    end
  end

  def destroy
    @booking.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to root_url
  end


  private

  def booking_params
    params.require(:booking).permit(:notice, :start_date, :end_date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
