module Frequency
  class ResetPurchased

    def self.process
      obj = new
      obj.run
    end

    def initialize
      @items = Item.all
      @today = Date.today()
    end

    def run
      # iterate through the items. if the item.nextpurchasedate is the same as today, then set item.purchased to false and reset next purchase date to nil
      @items.each do |i|
        if i.next_purchase_date == @today
          i.update({purchased: false, next_purchase_date: nil})
        end
      end
    end
  end
end