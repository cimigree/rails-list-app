class StoresController < ApplicationController
  before_action :store, only: %i[show edit all_items update destroy]

  def index
    @stores = Store.all.order(name: :asc)
  end

  def show
    @items_by_store = @store.items.joins(:category).merge(Category.order(name: :asc))
    @store
    categories = @store.items.joins(:category).select(:category_id).distinct.pluck(:category_id)
    uniq_categories = categories.reject { |item| item.nil? }
    @store_categories = uniq_categories.map { |uc| Category.find(uc).name }
  end

  def all_items
    @store = @store.items
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.create(store_params)
    if @store.save
      flash[:notice] = "#{@store.name} created"
      redirect_to stores_path
    else
      render 'new'
    end
  end

  def edit
    @store
  end

  def update
    @store
    if @store.update_attributes(store_params)
      flash[:notice] = "Store updated"
      redirect_to stores_path
    else
      render 'edit'
    end
  end

  def destroy
    @store.destroy
    flash[:notice] = "Store deleted"
    redirect_to stores_url
  end

private

  def store_params
    params.require(:store).permit(:name)
  end

  def store
    @store = Store.find(params[:id])
  end
end