class Admin::CreaturesController < ApplicationController
  def new
    @creature = Creature.new
  end
end
