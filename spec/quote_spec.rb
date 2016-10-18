# coding: utf-8
require 'market'
describe 'Quotes' do
  context 'Given an offer and payment period' do
    let(:offer) do
      Zopa::Market::Offer.new('Rate' => 0.07, 'Available' => 1000) 
    end
    
    let(:payment_period) { 36 }

    let(:quote) { Zopa::Market::Quote.new(offer, payment_period) }

    it 'returns the loan rate offered to 1 d.p.' do
      expect(quote.rate).to eq '7.0%'
    end

    it 'returns the loan requested' do
      expect(quote.requested_amount).to eq '£1000'
    end

    it 'returns the total repayment to 2 d.p.' do
      expect(quote.total_repayment).to eq '£1111.58'
    end

    it 'returns the monthly repayment to 2 d.p.' do
      expect(quote.monthly_repayment).to eq '£30.88'
    end
  end
end
