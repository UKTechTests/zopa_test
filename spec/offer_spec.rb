require 'spec_helper'
require 'offer'
describe 'An offer' do
  it 'returns the interest rate as a percentage' do
    offer = Zopa::Market::Offer.new('Available' => 15000.0, 'Rate' => 0.032)
    
    expect(offer.interest_rate).to be_within(0.001).of 3.2
  end

  it 'returns the amount that may be borrowed' do
    offer = Zopa::Market::Offer.new('Available' => 15000.0, 'Rate' => 0.032)
    
    expect(offer.available).to be_within(0.001).of 15000
  end

  it 'returns the monthly repayment' do
    offer = Zopa::Market::Offer.new('Available' => 15000.0, 'Rate' => 0.032)
    
    expect(offer.monthly_payment(36)).to be_within(0.01).of 437.54
  end

  it 'returns the total repayment' do
    offer = Zopa::Market::Offer.new('Available' => 15000.0, 'Rate' => 0.032)
    
    expect(offer.total_payment(36)).to be_within(0.01).of 15751.49
  end
end
