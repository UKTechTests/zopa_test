# README
## Zopa Technical Test

There is a need for a rate calculation system allowing prospective borrowers to
obtain a quote from our pool of lenders for 36 month loans. This system will
take the form of a command-line application.

You will be provided with a file containing a list of all the offers being made
by the lenders within the system in CSV format, see the example market.csv file
provided alongside this specification.

You should strive to provide as low a rate to the borrower as is possible to
ensure that Zopa's quotes are as competitive as they can be against our
competitors'. You should also provide the borrower with the details of the
monthly repayment amount and the total repayment amount.

Repayment amounts should be displayed to 2 decimal places and the rate of the
loan should be displayed to one decimal place.

Borrowers should be able to request a loan of any £100 increment between £1000
and £15000 inclusive. If the market does not have sufficient offers from
lenders to satisfy the loan then the system should inform the borrower that it
is not possible to provide a quote at that time.


## Running The Program
- Ruby version required: 2.2.5

```bundle exec ruby quote.rb path/to/market.csv amount```

## Running The Tests
 ```bundle exec rspec -cfd``` or ```bundle exec guard start```

## Assumptions
 To calculate the monthly repayments, the exact formula has been used (see [compound interest](
   https://en.wikipedia.org/wiki/Compound_interest#Monthly_amortized_loan_or_mortgage_payments)).

No edge cases have been considered in solving this problem.
Edge cases have been identified and listed in the INBOX markdown
and would be the topic of a conservation with the user.
