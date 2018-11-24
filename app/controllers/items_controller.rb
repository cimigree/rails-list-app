class ItemsController < ApplicationController
  before_action :item, only: %i[show edit update update_purchased destroy]
  
  def index
    Frequency::ResetPurchased.process()
    @items = Item.needed.includes(:category).order(name: :asc)
  end

  def items_all
    @items = Item.all.includes(:category).order(name: :asc)
  end

  def show
    @item
  end

  def new
    @item = Item.new
  end

  def create
    store_ids = params[:item][:store_ids]
    @item = Item.create(item_params.except("store_ids"))
    @item.store_ids = store_ids
    if @item.save
      flash[:notice] = "#{@item.name} created"
      redirect_to items_url
    else
      render 'new'
    end
  end

  def edit
    @item    
  end

  def update_purchased
    @item.update_attributes({purchased: true, date_purchased: Date.today()})
    Frequency::CalcNextPurchaseDate.process(@item.id) if @item.purchased == true
    redirect_to items_url
  end

  def update
    store_ids = params[:item][:store_ids]
    @item.update_attributes(item_params.except("store_ids"))
    @item.store_ids = store_ids
    if @item.save
      flash[:notice] = "#{@item.name} updated"
      redirect_to items_url
    else
      render 'edit'
    end

  end

  def destroy
    @item.destroy
    flash[:notice] = "Item deleted"
    redirect_to items_url
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :brand_name,
      :quantity,
      :coupon,
      :note,
      :purchased,
      :frequency,
      :category_id,
      :date_purchased,
      stores_attributes: [:id, :name]
    ).merge(date_purchased: @date_purchased)
  end

  def item
    @item = Item.find(params[:id])
  end

end