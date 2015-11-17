require 'till.rb'

describe Till do

  subject(:till) { described_class.new }

  context '#initialize' do

    it 'initializes with a shope info array' do
      expect(till.shop_info.class).to be Array
    end
  end

  context '#show_price' do

    it 'returns price of item' do
      expect(till.show_price('Cafe Latte')).to be 4.75
    end
  end

  context '#add_to_order' do

    it 'adds item to order' do
      till.add_to_order(1, 'Cappucino')
      expect(till.order).to eq( {Cappucino: 1} )
    end

    it 'adds correct quantity of items to order' do
      till.add_to_order(3,'Cappucino')
      expect(till.order).to eq( {Cappucino: 3} )
    end
  end

  context '#calculate_total' do

    it 'returns total of order' do
      allow(till).to receive(:order) { {Cappucino: 2, "Muffin Of The Day": 2} }
      till.calculate_total
      expect(till.total).to be 16.80
    end
  end

  context '#calculate_tax' do

    it 'returns total tax of order' do
      allow(till).to receive(:total) { 16.80 }
      expect(till.calculate_tax).to be 1.45
    end
  end

  context '#calculate_change' do

    it 'returns change due' do
      allow(till).to receive(:total) {16.80}
      expect(till.calculate_change(20)).to be 3.2
    end
  end

  context '#calculate_discount' do

    it 'discounts 5% for orders over £50' do
      allow(till).to receive(:total) {75}
      till.calculate_discount
      expect(till.discount).to be 3.75
    end

    it 'discounts 10% for muffins' do
      allow(till).to receive(:order) { {Cappucino: 2, "Muffin Of The Day": 2} }
      till.calculate_discount
      expect(till.discount).to be 0.91
    end
  end

end
