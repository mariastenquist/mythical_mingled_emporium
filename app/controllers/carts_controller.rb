class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    creature = Creature.find(params[:creature_id])

    @cart.add_creature(creature.id)
    session[:cart] = @cart.contents

    flash[:notice] = "You now have #{pluralize(@cart.count_of(creature.id), creature.breed)}."

    redirect_back(fallback_location: root_path)
  end

  def index
  end

  def update
    if params[:change_quantity] == "increment"
      @cart.contents[params[:creature_id]] += 1
    elsif params[:change_quantity] == "decrement"
      @cart.contents[params[:creature_id]] -= 1
    end
    session[:cart] = @cart.contents
    redirect_to '/carts'
  end

  def destroy
    creature = Creature.find(params[:creature_id])

    @cart.delete_creature(creature.id)
    session[:cart] = @cart.contents

    flash[:notice] = "Successfully removed #{view_context.link_to(creature.breed, creature_path(creature))} from your cart."

    redirect_back(fallback_location: root_path)
  end
end
