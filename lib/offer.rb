module Zopa
  class Market
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
end
