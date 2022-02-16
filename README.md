## 起个名字：wrapper to the exchangerate.host API

This is a package to interface with the exchangerate.host API. The exchangerate.host is an API that can get the currency exchange rate and the history trend of the currency. 

For more information about the API, you can visit the website: https://exchangerate.host/#/

# Function

## currency_time_series

This function need the user input the currency to change from and the currency to change to.

    ```R
    convert_currency("CAD", "USD")
    ```

![Output Picture](picture/convert_currency.png)
