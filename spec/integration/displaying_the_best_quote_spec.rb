# coding: utf-8
require 'spec_helper'
require 'loans'
require 'csv'
require 'market'
describe 'Displaying the best quote' do
  before :each do
    fixtures_dir = File.join(File.dirname(__FILE__), 'file_fixtures')
    markets_csv = File.join(fixtures_dir, 'market.csv')
    markets = Zopa::Market.new(
      CSV.new(File.open(markets_csv), headers: true, converters: [:float]))
    @loans = Zopa::Loans.new markets
  end

  it 'displays a quote with the lowest rate' do
    loan = 1000
    payment_period = 36
    
    best_quote = @loans.display_best_quote(loan, payment_period)

    expect(best_quote).to include 'Rate: 6.1%'
  end
end
