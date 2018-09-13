package io.yoba.tinkoff.converter

data class CurrencyResponse(val results: Map<String, Currency>)

data class Currency(val currencyName: String, val id: String) {
    val fullCurrencyName: String
        get() = id
}