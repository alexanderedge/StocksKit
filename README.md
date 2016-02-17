# StocksKit

A framework for fetching stock information and exchange rates from the Yahoo API.

# Usage

Fetching one or more quotes is straightforward:

```
Quote.fetch(["MSFT","AAPL"]) { result in

  switch result {
    case .Success(let quotes):
        // do something with the quotes
        break
    case .Failure(let error):
        // handle the error
        break
  }

}.resume()

```

As is fetching one or more exchange rates:

```
ExchangeRate.fetch(["USDGBP","GBPEUR"]) { result in

  switch result {
    case .Success(let exchangeRates):
        // do something with the exchange rates
        break
    case .Failure(let error):
        // handle the error
        break
  }

}.resume()

```

# Requirements

iOS 8.0 / Mac OS 10.10
