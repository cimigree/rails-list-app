class ItemsController < ApplicationController
  before_action :item, only: %i[show edit update update_purchased destroy]
  
  def index
    Frequency::ResetPurchased.process()
    @items = Item.all.joins(:category).merge(Category.order(name: :asc))
    uniq_categories_needed = Item.where("purchased=false").distinct.pluck(:category_id).compact!
    @item_categories_needed = uniq_categories_needed.map { |uc| Category.find(uc).name }.sort
    uniq_categories = Item.distinct.pluck(:category_id).compact!
    @item_categories = uniq_categories.map { |uc| Category.find(uc).name }.sort
  end

  def show
    @item
  end

  def new
    @item = Item.new
    if request.referer != nil
      from_path_array = URI(request.referer).path.split("/")
    else 
      from_path_array = []
    end
    if from_path_array[1] == "stores" 
      @item.store_ids = [from_path_array[2].to_i]
    elsif from_path_array[1] == "categories"
      @item.category_id = from_path_array[2].to_i
    else
      return
    end
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
    unless @item.purchased
      @item.update_attributes({purchased: true, date_purchased: Date.today()})
    else
      @item.update_attributes({purchased: false, date_purchased: nil})
    end
    Frequency::CalcNextPurchaseDate.process(@item.id) if @item.purchased == true
    redirect_back fallback_location: URI(request.referer).path
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
    redirect_back fallback_location: URI(request.referer).path
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