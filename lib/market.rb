# coding: utf-8
require 'ostruct'
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
        rate: "#{best_quote.interest_rate.round(1)}%",
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
      rate * 100
    end

    def total_payment(payment_period)
      payment_period * monthly_payment(payment_period)
    end

    # The formula for the monthly payment is assumed to the exact one
    # P = Li/[1 - (1 + i)^-n]
    # (see https://en.wikipedia.org/wiki/Compound_interest)
    def monthly_payment(payment_period)
      monthly_interest = rate / 12

      (available * monthly_interest) /
        (1 - (1 + monthly_interest)**(-payment_period))
    end
  end
end
