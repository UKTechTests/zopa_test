# coding: utf-8
require 'spec_helper'
require 'market'
describe "Zopa's Lending Market" do
  let(:payment_period) { 36 }

  describe 'finding the best quote' do
    context 'when an offer is insufficient' do
      it 'returns no quote' do
        loan = 1300
        market = Zopa::Market.new(
          [{ 'Lender' => 'Len', 'Rate' => 0.0234, 'Available' => 600 }]
        )
        
        best_quote = market.best_quote(loan, payment_period)
        
        expect(best_quote).to be_nil
      end
    end

    context 'when the market has multiple offers' do
      context 'all of which match the loan requested' do
        it 'quotes the offer with the lowest rate' do
          loan = 1400
        
          best_quote = Zopa::Market.new(
            [
              { 'Lender' => 'A', 'Rate' => 0.156, 'Available' => 1400 },
              { 'Lender' => 'B', 'Rate' => 0.0156, 'Available' => 1400 },
              { 'Lender' => 'C', 'Rate' => 0.0234, 'Available' => 1400 }
            ]
          ).best_quote(loan, payment_period)
        
          expect(best_quote.rate).to eq '1.6%'
        end
      end

      context 'but has insufficient offers with very low rates' do
        it 'quotes only the matching offer with the lowest rate' do
          loan = 1400
        
          best_quote = Zopa::Market.new(
            [
              { 'Lender' => 'A', 'Rate' => 0.156, 'Available' => 1400 },
              { 'Lender' => 'B', 'Rate' => 0.0156, 'Available' => 1400 },
              { 'Lender' => 'C', 'Rate' => 0.0034, 'Available' => 400 }
            ]
          ).best_quote(loan, payment_period)
        
          expect(best_quote.rate).to eq '1.6%'
        end
      end
    end

    context 'when the market has no offers' do
      it 'returns no quote' do
        loan = 1400
        
        best_quote = Zopa::Market.new([]).best_quote(loan, payment_period)
        
        expect(best_quote).to be_nil
      end
    end
  end
end
