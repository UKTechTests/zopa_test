module Zopa
  class Loans
    attr_reader :market
    def initialize(market)
      @market = market
    end

    def display_best_quote(amount, payment_period = 36)
      quote = market.best_quote(amount, payment_period)

      return 'No quotes could be found at this time.' if quote.nil?
     
      "Requested amount: #{quote.requested_amount}\n" +
        "Rate: #{quote.rate}\n" +
        "Monthly repayment: #{quote.monthly_repayment}\n" +
        "Total repayment: #{quote.total_repayment}"
    end
  end
end
