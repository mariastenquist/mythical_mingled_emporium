class Admin::CreaturesController < ApplicationController
  def new
    @creature = Creature.new
  end

  def create
    @creature = Creature.new(creature_params)
    if @creature.save
      CreaturesCategory.create(creature_id: @creature.id,
                               category_id: params[:creature][:categories].to_i)
      flash[:success] = 'Creature successfully created!'
      redirect_to admin_creature_path(@creature)
    else
      flash[:failure] = 'Retry creature creation'
      render :new
    end
  end

  def show
    @creature = Creature.find(params[:id])
  end

  private

  def creature_params
    params.require(:creature).permit(:breed,
                                     :description,
                                     :price,
                                     :image_url,
                                     :category_id)
  end
end
