# coding: utf-8
require 'ostruct'
describe "Zopa's Lending Market" do
  let(:payment_period) { 36 }
  
  describe 'finding the best quote' do
    module Zopa
      class Market
        def initialize *quotes
          @quotes = quotes.map { |quote| Quote.new quote }
        end

        def best_quote(loan, payment_period)
          return nil if @quotes.none? { |quote| quote.offering? loan }

          with_lowest_rate =
            @quotes.
            select { |quote| quote.offering? loan }.
            min_by { |quote| quote.rate }

          payment_plan(with_lowest_rate, payment_period)
        end

        private

        def payment_plan(best_quote, payment_period)
          OpenStruct.new(
            rate: best_quote.interest_rate,
            requested_amount: "£#{best_quote.available}",
            monthly_repayment:
              "£#{best_quote.monthly_payment(payment_period).round(2)}",
            total_repayment:
              "£#{best_quote.total_payment(payment_period).round(2)}"
          )
        end
      end

      class Quote
        attr_reader :available, :rate
        
        def initialize quote
          @rate = quote['Rate']
          @available = quote['Available']
        end

        def offering? loan
          available == loan
        end

        def interest_rate
          "#{(rate * 100).round(1)}%"
        end

        def total_payment(payment_period)
          payment_period * monthly_payment(payment_period)
        end

        # The formula for the monthly payment is assumed to the exact one
        # P = Li/[1 - (1 + i)^-n]
        # (see https://en.wikipedia.org/wiki/Compound_interest)
        def monthly_payment(payment_period)
          monthly_interest = rate / 12

          (available * monthly_interest)/
            (1 - (1 + monthly_interest)**(-payment_period))
        end
      end
    end

    context 'when the market has only one quote' do
      let(:loan) { 1000 }
      let(:market) do
        Zopa::Market.new(
          { 'Lender' => 'Len', 'Rate' => 0.07, 'Available' => 1000 }
        )
      end
      
      it 'returns the loan rate offered to 1 d.p.' do
        best_quote = market.best_quote(loan, payment_period)

        expect(best_quote.rate).to eq '7.0%'
      end

      it 'returns the loan requested' do
        best_quote = market.best_quote(loan, payment_period)

        expect(best_quote.requested_amount).to eq '£1000'
      end

      it 'returns the total repayment to 2 d.p.' do
        best_quote = market.best_quote(loan, payment_period)

        expect(best_quote.total_repayment).to eq '£1111.58'
      end

      it 'returns the monthly repayment to 2 d.p.' do
        best_quote = market.best_quote(loan, payment_period)             

        expect(best_quote.monthly_repayment).to eq '£30.88'
      end
    end

    context 'when the market has one different quote' do
      let(:loan) { 1200 }
      let(:market) do
        Zopa::Market.new(
          { 'Lender' => 'Len', 'Rate' => 0.0453, 'Available' => 1200 }
        )
      end

      it 'returns the loan rate offered to 1 d.p.' do
        best_quote = market.best_quote(loan, payment_period)

        expect(best_quote.rate).to eq '4.5%'
      end

      it 'returns the loan requested' do
        best_quote = market.best_quote(loan, payment_period)
        
        expect(best_quote.requested_amount).to eq '£1200'
      end

      it 'returns the monthly repayment to 2 d.p.' do
        best_quote = market.best_quote(loan, payment_period)
        
        expect(best_quote.monthly_repayment).to eq '£35.71'
      end

      it 'returns the total repayment to 2 d.p.' do
        best_quote = market.best_quote(loan, payment_period)
        
        expect(best_quote.total_repayment).to eq '£1285.65'
      end
    end

    context 'when the one quote that is offered is insufficient' do
      it 'returns no quote' do
        loan = 1300
        market = Zopa::Market.new(
          { 'Lender' => 'Len', 'Rate' => 0.0234, 'Available' => 600 }
        )
        
        best_quote = market.best_quote(loan, payment_period)
        
        expect(best_quote).to be_nil
      end
    end

    context 'when the market has multiple quotes' do
      context 'all of which match the loan requested' do
        it 'returns the quote with the lowest rate' do
          loan = 1400
        
          best_quote = Zopa::Market.new(
            { 'Lender' => 'A', 'Rate' => 0.156, 'Available' => 1400 },
            { 'Lender' => 'B', 'Rate' => 0.0156, 'Available' => 1400 },
            { 'Lender' => 'C', 'Rate' => 0.0234, 'Available' => 1400 },
          ).best_quote(loan, payment_period)
        
          expect(best_quote.rate).to eq '1.6%'
        end
      end

      context 'but has insufficient quotes with very low rates' do
        it 'returns only the matching with the lowest rate' do
          loan = 1400
        
          best_quote = Zopa::Market.new(
            { 'Lender' => 'A', 'Rate' => 0.156, 'Available' => 1400 },
            { 'Lender' => 'B', 'Rate' => 0.0156, 'Available' => 1400 },
            { 'Lender' => 'C', 'Rate' => 0.0034, 'Available' => 400 }
          ).best_quote(loan, payment_period)
        
          expect(best_quote.rate).to eq '1.6%'
        end
      end
    end

    context 'when the market has no quotes' do
      it 'returns no quote' do
        loan = 1400
        
        best_quote = Zopa::Market.new.best_quote(loan, payment_period)
        
        expect(best_quote).to be_nil
      end
    end
  end
end
