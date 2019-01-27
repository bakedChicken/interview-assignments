package io.yoba.tinkoff.converter

import io.reactivex.Single
import retrofit2.http.GET
import retrofit2.http.Query

interface ConverterApi {
    @GET("currencies")
    fun getCurrencies(): Single<Map<String, Map<String, Currency>>>

    @GET("convert")
    fun convertCurrencies(
        @Query("q") currencyPair: String,
        @Query("compact") compact: String = "ultra"
    ): Single<Map<String, String>>
}