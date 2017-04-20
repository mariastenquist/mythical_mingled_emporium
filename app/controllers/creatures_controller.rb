class CreaturesController < ApplicationController
  def index
    @creatures = Creature.active
  end

  def show
    @creature = Creature.find(params[:id])
  end
end
