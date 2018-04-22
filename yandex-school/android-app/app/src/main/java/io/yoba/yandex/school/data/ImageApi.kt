package io.yoba.yandex.school.data

import io.reactivex.Single
import retrofit2.http.GET

interface ImageApi {
    @GET("images")
    fun getImages(): Single<List<Image>>
}