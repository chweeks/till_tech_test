class Till

  attr_reader :shop_info, :order, :total

  def initialize
    shop_info_file = File.read('hipstercoffee.json')
    @shop_info = JSON.parse(shop_info_file)
    @order = {}
  end

  def show_price item
    self.shop_info[0]['prices'][0][item]
  end

  def add_to_order(quantity, item)
    self.order[item.to_sym] = quantity
  end

  def calculate_total
    items = self.order.keys
    items.inject(0) do |total, item|
      total += (show_price(item.to_s) * self.order[item])
    end
  end

end
