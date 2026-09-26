package io.yoba.yandex.school.interactors

import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.yoba.yandex.school.data.ImageApi
import io.yoba.yandex.school.data.entities.Image
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class NetworkInteractor @Inject constructor(val imageApi: ImageApi, val databaseInteractor: DatabaseInteractor) {
    fun getImages(): Single<List<Image>> {
        return imageApi.getImages()
            .subscribeOn(Schedulers.io())
            .doOnSuccess {
                databaseInteractor.deleteImages()
                databaseInteractor.saveImages(it)
            }
            .observeOn(AndroidSchedulers.mainThread())
    }
}