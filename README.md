# personal_finance_calculator

A new Flutter project.

Calculates approximately when you may retire based on the amount of money inputted. May (?) calculate how long a timeframe is needed to reach x value in assets or how much assets is accrued in y timeframe (years/months/days etc.)

TODO:

Convert inputs into 2dp (perhaps find/import currency database?) - done

Complete ASSET page which would automatically calculate the sum of all asset inputs (e.g. bank accounts, investments, pensions etc.) - done

    by extension implement function that allows addition of multiple bank accounts into bank account section, multiple investments (e.g. funds, shares) into investments

Complete LIABILITIES page in similar fashion to ASSET page - done

Take TOTAL of ASSET page and subtract by LIABILITIES to calculate CURRENT FUNDS automatically if possible, else calculate when a button is pressed - done

Factor in expected errors (e.g. no negative values in years, initial funds are necessary) and display them onscreen

Implement some animations (try to figure out how to implement function that can call an animation) - in progress

Set up section for investment where stock data can be imported, displayed and included in calculations

Add feature that clears data on call/pressed so calculations can be done again

Figure out how to store data/numbers in app so it can be recalled when app runs again

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
