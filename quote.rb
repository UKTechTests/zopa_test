$LOAD_PATH << 'lib/zopa'
require 'market'
require 'loans'
require 'csv'
market_csv = ARGV[0]
amount = ARGV[1].to_i
markets = Zopa::Market.new(
  CSV.new(File.open(market_csv), headers: true, converters: [:float, :integer])
)

loans = Zopa::Loans.new markets

puts loans.display_best_quote amount
