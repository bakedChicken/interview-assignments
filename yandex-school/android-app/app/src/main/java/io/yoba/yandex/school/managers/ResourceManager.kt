package io.yoba.yandex.school.managers

import android.content.Context
import android.support.annotation.StringRes
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class ResourceManager @Inject constructor(val context: Context) {
    operator fun get(@StringRes resId: Int) = context.getString(resId)
}