package io.yoba.tinkoff.converter

import io.reactivex.Single

class ConverterRepository(private val converterApi: ConverterApi) {
    private val memoryCache = HashMap<String, String>()

    fun convertCurrencies(from: String, to: String): Single<String?> {
        val currencyPair = "${from}_$to"

        if (memoryCache.contains(currencyPair)) {
            return Single.just(memoryCache[currencyPair])
        }

        return converterApi.convertCurrencies(currencyPair)
            .map { it.values.firstOrNull() }
            .doAfterSuccess { result ->
                result?.let {
                    memoryCache[currencyPair] = it
                }
            }
    }
}