package io.yoba.yandex.school.utils.extensions

import io.reactivex.Single

fun <T> Single<T>.switchIfValueIsEmpty(other: () -> Single<T>): Single<T> where T : List<*> {
    return flatMap {
        if (it.isEmpty()) other() else Single.just(it)
    }
}