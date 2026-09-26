package io.yoba.yandex.school.data

import io.reactivex.Single
import io.yoba.yandex.school.data.entities.Image
import retrofit2.http.GET

interface ImageApi {
    @GET("images")
    fun getImages(): Single<List<Image>>
}