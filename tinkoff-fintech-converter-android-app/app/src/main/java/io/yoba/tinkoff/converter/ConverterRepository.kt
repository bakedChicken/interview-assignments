package io.yoba.tinkoff.converter

import io.reactivex.Single

class ConverterRepository(private val converterApi: ConverterApi) {
    private val memoryCache = HashMap<String, Double>()

    fun getCurrencies(): Single<List<Currency>> {
        return converterApi.getCurrencies().map {
            it.values.first().values.toList()
        }
    }

    fun convertCurrencies(from: String, to: String, count: Double?): Single<Double> {
        if (count == null) {
            return Single.just(0.0)
        }

        if (from == to) {
            return Single.just(count)
        }

        val currencyPair = "${from}_$to"
        val invertedPair = "${to}_$from"

        if (memoryCache.contains(currencyPair)) {
            return Single.just(memoryCache[currencyPair]!! * count)
        } else if (memoryCache.contains(invertedPair)) {
            return Single.just(memoryCache[invertedPair]!! * count)
        }

        return converterApi.convertCurrencies(currencyPair)
            .map { it.values.firstOrNull()!!.toDouble() }
            .doAfterSuccess { result ->
                result?.let {
                    memoryCache[currencyPair] = it
                    memoryCache[invertedPair] = 1 / it
                }
            }
    }
}