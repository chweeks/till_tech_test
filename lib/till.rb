class Till

  attr_reader :shop_info, :order, :total, :discount

  def initialize
    shop_info_file = File.read('hipstercoffee.json')
    @shop_info = JSON.parse(shop_info_file)
    @order = {}
    @total = 0
    @discount = 0
  end

  def show_price(item)
    shop_info[0]['prices'][0][item]
  end

  def add_to_order(quantity, item)
    order[item.to_sym] = quantity
  end

  def calculate_total
    items = order.keys
    items.each do |item|
      @total += item_total(item)
    end
  end

  def calculate_tax
    (total * 0.0864).round(2)
  end

  def calculate_change(payment)
    (payment - total).round(2)
  end

  def calculate_discount
    muffin_discount
    over_50_discount
  end

  private

  def item_total(item)
    (show_price(item.to_s) * order[item])
  end

  def over_50_discount
    @discount += total * 0.05 if total > 50
  end

  def muffin_discount
    order.keys.each do |item|
      if muffin_ordered?(item)
        @discount += ten_percent(item) * order[item]
      end
    end
  end

  def ten_percent(item)
    show_price(item.to_s) * 0.1
  end

  def muffin_ordered?(item)
    item.to_s.include?('Muffin')
  end
end
