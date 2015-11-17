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
      expect(till.calculate_total).to be 16.80
    end
  end

end
