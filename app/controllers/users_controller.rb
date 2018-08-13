class UsersController < ApplicationController

  def index
    @vendors = User.where(vendor: true)
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  def secret
    @vendor = User.today.where(vendor: true)
    @visitor = User.today.where(vendor: false)
    @flat = Flat.today
    @booking = Booking.today
    @user = current_user
    authorize @flat
  end

  def get_secret_email
    @vendor = User.today.where(vendor: true)
    @visitor = User.today.where(vendor: false)
    @flat = Flat.today
    @booking = Booking.today
    AdminMailer.report(@vendor, @visitor, @flat, @booking).deliver
    redirect_to :secret
  end

  private

  def not_allowed
    flash[:alert] = 'You do not have permission to access this page.'
    redirect_to root_path
  end
end
