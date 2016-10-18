# coding: utf-8
require 'ostruct'
module Zopa
  class Market
    attr_reader :offers
    
    def initialize *offers
      @offers = offers.map { |offer| Offer.new offer }
    end

    def best_quote(loan, payment_period)
      return nil if offers.none? { |offer| offer.offering? loan }

      with_lowest_rate =
        offers.
        select { |offer| offer.offering? loan }.
        min_by { |offer| offer.rate }


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

  class Offer
    attr_reader :available, :rate
        
    def initialize offer
      @rate = offer['Rate']
      @available = offer['Available']
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
