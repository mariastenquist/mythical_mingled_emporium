class Admin::CreaturesController < Admin::BaseController
  def index
    @creatures = Creature.all
  end
end
