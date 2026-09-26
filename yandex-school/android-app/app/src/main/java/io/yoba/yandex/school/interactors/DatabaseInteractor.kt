package io.yoba.yandex.school.interactors

import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import io.yoba.yandex.school.data.ImageDao
import io.yoba.yandex.school.data.entities.Image
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class DatabaseInteractor @Inject constructor(val imageDao: ImageDao) {
    fun getAllImages(): Single<List<Image>> {
        return imageDao.getAll()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    fun saveImages(images: List<Image>) {
        imageDao.saveAll(images)
    }

    fun deleteImages() {
        imageDao.deleteAll()
    }
}