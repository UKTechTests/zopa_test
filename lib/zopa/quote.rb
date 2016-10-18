# coding: utf-8
module Zopa
  class Market
    class Quote
      attr_reader :offer, :payment_period
      def initialize(offer, payment_period)
        @offer = offer
        @payment_period = payment_period
      end

      def requested_amount
        "£#{offer.available.to_i}"
      end

      def rate
        "#{offer.interest_rate.round(1)}%"
      end

      def monthly_repayment
        "£#{offer.monthly_repayment(payment_period).round(2)}"
      end

      def total_repayment
        "£#{offer.total_repayment(payment_period).round(2)}"
      end
    end
  end
end
