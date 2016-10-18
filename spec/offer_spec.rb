require 'spec_helper'
require 'offer'
describe 'An offer' do
  it 'returns the interest rate as a percentage' do
    offer = Zopa::Market::Offer.new('Available' => 250.0, 'Rate' => 0.032)
    
    expect(offer.interest_rate).to be_within(0.001).of 3.2
  end

  it 'returns the amount that may be borrowed'

  it 'returns the monthly repayment'

  it 'returns the total repayment'
end
