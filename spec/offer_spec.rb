require 'spec_helper'
require 'offer'
describe 'An offer' do
  let(:offer) do
    Zopa::Market::Offer.new('Available' => 15000.0, 'Rate' => 0.032)
  end
  
  it 'returns the interest rate as a percentage' do
    expect(offer.interest_rate).to be_within(0.001).of 3.2
  end

  it 'returns the amount that may be borrowed' do
    expect(offer.available).to be_within(0.001).of 15000
  end

  it 'returns the monthly repayment' do
    expect(offer.monthly_payment(36)).to be_within(0.01).of 437.54
  end

  it 'returns the total repayment' do
    expect(offer.total_repayment(36)).to be_within(0.01).of 15751.49
  end
end

describe 'Any offer' do
  let(:offer) do
    Zopa::Market::Offer.new('Available' => 1000.0, 'Rate' => 0.063)
  end
  
  it 'returns the interest rate as percentage' do
    expect(offer.interest_rate).to be_within(0.001).of 6.3
  end

  it 'returns the amount that may be borrowed' do
    expect(offer.available).to be_within(0.001).of 1000
  end

  it 'returns the monthly repayment' do
    expect(offer.monthly_payment(36)).to be_within(0.01).of 30.56
  end

  it 'returns the total repayment' do
    expect(offer.total_repayment(36)).to be_within(0.01).of 1100.09
  end
end
