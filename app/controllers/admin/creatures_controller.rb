class Admin::CreaturesController < Admin::BaseController
  def index
    @creatures = Creature.all
  end

  def edit
    @creature = Creature.find(params[:id])
  end

  def update
    creature = Creature.find(params[:id])
    creature.update(creature_params)

    redirect_to admin_creatures_path
  end

  private
  def creature_params
    params.require(:creature).permit(:breed, :description, :price, :status, :image_url)
  end
end
