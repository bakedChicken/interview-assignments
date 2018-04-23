package io.yoba.yandex.school.data

import io.reactivex.Single
import io.yoba.yandex.school.data.entities.Image
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class ImageApiService @Inject constructor(val imageApi: ImageApi) {
    fun getImages(): Single<List<Image>> {
        return imageApi.getImages()
    }
}