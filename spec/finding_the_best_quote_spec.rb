# coding: utf-8
require 'ostruct'
describe "Zopa's Lending Market" do
  describe 'finding the best quote' do
    context 'when the market has only one quote' do
      module Zopa
        class Market
          def initialize quote

          end

          def best_quote loan
            OpenStruct.new(
              rate: '7.0%', requested_amount: '£1000',
              monthly_repayment: '£30.88'
            )
          end
        end
      end
      
      it 'returns the loan rate offered to 1 d.p.' do
        loan = 1000
        
        best_quote = Zopa::Market.new(
          { 'Lender' => 'Len', 'Rate' => 0.07, 'Available' => 1000 }
        ).best_quote(loan)
        
        expect(best_quote.rate).to eq '7.0%'
      end

      it 'returns the loan requested' do
        loan = 1000
        
        best_quote = Zopa::Market.new(
          { 'Lender' => 'Len', 'Rate' => 0.07, 'Available' => 1000 }
        ).best_quote(loan)
        
        expect(best_quote.requested_amount).to eq '£1000'
      end

      it 'returns the total repayment to 2 d.p.'

      it 'returns the monthly repayment to 2 d.p.' do
        loan = 1000
        best_quote = Zopa::Market.new(
          {'Lender' => 'Len', 'Rate' => 0.07, 'Available' => 1000 }
        ).best_quote(loan)
                     
        expect(best_quote.monthly_repayment).to eq '£30.88'
      end
    end
  end
end
