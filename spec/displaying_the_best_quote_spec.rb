# coding: utf-8
require 'ostruct'
require 'loans'
describe 'Displaying the best quote' do
  let(:markets) { double(:markets_csv) }
  let(:payment_period) { 36 }

  describe 'when a best quote is found' do
    let(:loan) { 1000 }

    let(:a_best_quote) do
      OpenStruct.new(
        monthly_repayment: '£30.78',
        total_repayment: '£1108.10',
        rate: '7.0%',
        requested_amount: '£1000'
      )
    end

    before(:each) do
      allow(markets).to(
        receive(:best_quote).with(loan, payment_period).
        and_return a_best_quote)
    end

    it 'displays the monthly repayment amount' do
      best_quote =
        Zopa::Loans.new(markets).display_best_quote(loan, payment_period)
      
      expect(best_quote).to include 'Monthly repayment: £30.78'
    end

    it 'displays the total repayment amount' do
      best_quote =
        Zopa::Loans.new(markets).display_best_quote(loan, payment_period)
      
      expect(best_quote).to include 'Total repayment: £1108.10'
    end

    it 'displays the loan rate' do
      best_quote =
        Zopa::Loans.new(markets).display_best_quote(loan, payment_period)
      
      expect(best_quote).to include 'Rate: 7.0%'
    end

    it 'displays the loan requested' do
      best_quote =
        Zopa::Loans.new(markets).display_best_quote(loan, payment_period)

      expect(best_quote).to include 'Requested amount: £1000'
    end
  end

  describe 'when a different best quote is found' do
    let(:loan) { 1100 }

    let(:a_best_quote) do
      OpenStruct.new(
        requested_amount: '£1100',
        monthly_repayment: '£33.38',
        total_repayment: '£1201.86',
        rate: '6.0%'
      )
    end

    before(:each) do
      allow(markets).to(
        receive(:best_quote).with(loan, payment_period).
        and_return a_best_quote
      )
    end
    
    it 'displays the monthly repayment amount' do
      best_quote =
        Zopa::Loans.new(markets).display_best_quote(loan, payment_period)
      
      expect(best_quote).to include 'Monthly repayment: £33.38'
    end

    it 'displays the total replayment amount' do
      best_quote =
        Zopa::Loans.new(markets).display_best_quote(loan, payment_period)
      
      expect(best_quote).to include 'Total repayment: £1201.86'
    end

    it 'displays the loan rate' do
      best_quote =
        Zopa::Loans.new(markets).display_best_quote(loan, payment_period)
      
      expect(best_quote).to include 'Rate: 6.0%'
    end

    it 'displays the loan requested' do
      best_quote =
        Zopa::Loans.new(markets).display_best_quote(loan, payment_period)
      
      expect(best_quote).to include 'Requested amount: £1100'
    end
  end

  describe 'when the market has insufficient offers from lenders' do
    it 'states that no quotes could be found' do
      loan = 1500
      allow(markets).to(
        receive(:best_quote).with(loan, payment_period).and_return nil)
      
      best_quote =
        Zopa::Loans.new(markets).display_best_quote(loan, payment_period)

      expect(best_quote).to eq 'No quotes could be found at this time.'
    end
  end
end
