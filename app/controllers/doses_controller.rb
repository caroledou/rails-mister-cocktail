class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = Cocktail.find(params[:cocktail_id])
      if @dose.save
        redirect_to cocktail_path(@cocktail.id)
      else
        render :new
      end
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@cocktail.id)
  end

  private

  def dose_params
    params.require(:dose).permit(:ingredient_id, :cocktail_id, :description)
  end
end
