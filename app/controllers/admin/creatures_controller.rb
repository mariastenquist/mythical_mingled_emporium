class Admin::CreaturesController < Admin::BaseController
  def new
    @creature = Creature.new
  end

  def create
    @creature = Creature.new(creature_params)
    if @creature.save
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
    params.require(:creature).permit(:breed,
                                     :description,
                                     :price,
                                     :image_url,
                                     :category_id,
                                     :status)
  end
end
