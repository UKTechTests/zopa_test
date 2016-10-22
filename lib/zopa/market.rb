# coding: utf-8
require_relative './quote'
require_relative './offer'
module Zopa
  class Market
    include Enumerable
    attr_reader :offers
    
    def initialize offers
      @offers = offers.map { |offer| Offer.new offer }
    end

    def best_quote(loan, payment_period)
      return nil if none? { |offer| offer.offering? loan }

      with_lowest_rate =
        select { |offer| offer.offering? loan }.
        min_by { |offer| offer.rate }

      Quote.new(with_lowest_rate, payment_period)
    end

    def each
      offers.each { |offer| yield offer }
    end
  end
end
