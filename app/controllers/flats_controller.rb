class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @flats = FlatsQuery.new.filter(params[:filter]).page(params[:page])
    # @flats = Flat.filter(params[:filter]).page(params[:page])
  end

  def show
    @reserved = FlatsQuery.new.reserved_date_array(@flat.id)
    gon.id = params[:id]
    respond_to do |format|
        format.html
        format.json { render json: @reserved }
        format.js
      end
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def edit
  end

  def create
    @flat = current_user.flats.build(flat_params) if current_user.vendor
    authorize @flat

    if @flat.save
      # UserMailer.signup_cofirmation(current_user).deliver
      flash[:notice] = 'Flat was successfully created.'
      redirect_to @flat
    else
      flash[:alert] = "Flat wasn't created."
      render :new
    end
  end

  def update
    if @flat.update(flat_params)
      flash[:notice] = 'Flat was successfully updated.'
      redirect_to @flat
    else
      flash[:alert] = 'Flat was not updated.'
      render :edit
    end
  end

  def destroy
    @flat.destroy
    redirect_to flats_url
  end

private

  def flat_params
    params.require(:flat).permit(:name, :city, :address, :description, :capacity, :price, :image)
  end

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def not_allowed
    flash[:alert] = 'You do not have permission to access this page.'
    redirect_to root_path
  end

end
