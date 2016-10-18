# coding: utf-8
require_relative './quote'
require_relative './offer'
module Zopa
  class Market
    attr_reader :offers
    
    def initialize offers
      @offers = offers.map { |offer| Offer.new offer }
    end

    def best_quote(loan, payment_period)
      return nil if offers.none? { |offer| offer.offering? loan }

      with_lowest_rate =
        offers.
        select { |offer| offer.offering? loan }.
        min_by { |offer| offer.rate }

      Quote.new(with_lowest_rate, payment_period)
    end
  end
end
