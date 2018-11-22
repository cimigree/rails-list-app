class ItemsController < ApplicationController
  before_action :item, only: %i[show update destroy]
  def index
  end

  def items_all
    Item.all.includes(:category).order(name: :asc)
  end

  def show
    @item
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
  def item
    @item = Item.find(params[:id])
  end

end