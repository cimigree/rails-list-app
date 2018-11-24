class ItemsController < ApplicationController
  before_action :item, only: %i[show update destroy]
  
  def index
    Frequency::ResetPurchased.process()
    @items = Item.where(purchased: false).includes(:category).order(name: :asc)
  end

  def items_all
    Item.all.includes(:category).order(name: :asc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    store_ids = params[:item][:store_ids]
    @item = Item.create(item_params)
    @item = Item.create(item_params.except("store_ids"))
    @item.store_ids = store_ids
    if @item.save
      redirect_to @item
    else
      render 'new'
    end
  end

  def update
    unless @item.purchased
      if params[:item][:purchased] == true
        @date_purchased = Date.today()
      end
    end
    @item.update_attributes(item_params)
    Frequency::CalcNextPurchaseDate.process(@item.id) if @item.purchased == true
  end

  def destroy
    @item.destroy
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