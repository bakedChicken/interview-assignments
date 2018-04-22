package io.yoba.yandex.school.interactors

import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.yoba.yandex.school.data.Image
import io.yoba.yandex.school.data.ImageApiService
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class NetworkInteractor @Inject constructor(val imageApiService: ImageApiService) {
    fun getImages(): Single<List<Image>> {
        return imageApiService.getImages()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }
}