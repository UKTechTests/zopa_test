# coding: utf-8
describe 'Displaying the best quote' do
  describe 'when a best quote is found' do
    def display_best_quote(amount, markets)
      "Requested amount: £1000\n" +
      "Rate: 7.0%\n" +
      "Monthly repayment: £30.78\n" +
        "Total repayment: £1108.10"
    end

    let(:loan) { 1000 }
    let(:markets) { double(:markets_csv) }
    let(:a_best_quote) do
      {
        monthly_repayment: '£30.78',
        total_repayment: '£1108.10',
        rate: '7.0%',
        amount: '£1000'
      }
    end

    before(:each) do
      allow(markets).to(
        receive(:best_quote).with(loan).and_return a_best_quote)
    end

    it 'displays the monthly repayment amount to 2 d.p.' do
      best_quote = display_best_quote(loan, markets)
      
      expect(best_quote).to include 'Monthly repayment: £30.78'
    end

    it 'displays the total repayment amount to 2 d.p.' do
      best_quote = display_best_quote(loan, markets)
      
      expect(best_quote).to include 'Total repayment: £1108.10'
    end

    it 'displays the loan rate to 1 d.p.' do
      best_quote = display_best_quote(loan, markets)
      
      expect(best_quote).to include 'Rate: 7.0%'
    end

    it 'displays the loan requested' do
      best_quote = display_best_quote(loan, markets)
      
      expect(best_quote).to include 'Requested amount: £1000'
    end
  end

  describe 'when a different best quote is found' do
    def display_best_quote(loan, markets)
      "Rate: 6.0%\n" +
      "Monthly repayment: £33.38\n" +
        'Total repayment: £1201.86'
    end
    
    it 'displays the monthly repayment amount to 2 d.p.' do
      loan = 1100
      markets = double(:markets_csv)
      allow(markets).to(
        receive(:best_quote).with(loan).
        and_return(monthly_repayment: '£33.38')
      )
      
      best_quote = display_best_quote(loan, markets)
      
      expect(best_quote).to include 'Monthly repayment: £33.38'
    end

    it 'displays the total replayment amount to 2 d.p.' do
      loan = 1100
      markets = double(:markets_csv)
      allow(markets).to(
        receive(:best_quote).with(loan).
        and_return(total_repayment: '£1201.86')
      )
      
      best_quote = display_best_quote(loan, markets)
      
      expect(best_quote).to include 'Total repayment: £1201.86'
    end

    it 'displays the loan rate to 1 d.p.' do
      loan = 1100
      markets = double(:markets_csv)
      allow(markets).to(
        receive(:best_quote).with(loan).
        and_return(rate: '6.0%')
      )
      
      best_quote = display_best_quote(loan, markets)
      
      expect(best_quote).to include 'Rate: 6.0%'
    end

    it 'displays the loan requested'
  end

  describe 'when the market has insufficient offers from lenders' do
    it 'states that no quotes could be found'
  end
end
