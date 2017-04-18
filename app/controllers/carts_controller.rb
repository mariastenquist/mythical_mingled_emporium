class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    creature = Creature.find(params[:creature_id])

    @cart.add_creature(creature.id)
    session[:cart] = @cart.contents

    flash[:notice] = "You now have #{pluralize(@cart.count_of(creature.id), creature.breed)}."

    redirect_back(fallback_location: root_path)
  end

  def index; end

  def show; end

  def update
    if params[:change_quantity] == "increment"
      @cart.contents[params[:creature_id]] += 1
    elsif params[:change_quantity] == "decrement"
      @cart.contents[params[:creature_id]] -= 1 unless @cart.contents[params[:creature_id]].zero?
    end
    session[:cart] = @cart.contents
    redirect_to cart_path
  end

  def destroy
    creature = Creature.find(params[:creature_id])

    c_link = view_context.link_to(creature.breed, creature_path(creature))

    @cart.delete_creature(creature.id)
    session[:cart] = @cart.contents

    flash[:notice] = "Successfully removed #{c_link} from your cart."

    redirect_to cart_path
  end
end
