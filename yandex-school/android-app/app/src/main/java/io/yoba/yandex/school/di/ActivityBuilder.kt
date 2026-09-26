package io.yoba.yandex.school.di

import dagger.Module
import dagger.android.ContributesAndroidInjector
import io.yoba.yandex.school.activities.start.StartActivity
import io.yoba.yandex.school.activities.table.ImageTableActivity

@Module
abstract class ActivityBuilder {
    @ContributesAndroidInjector
    abstract fun bindStartActivity(): StartActivity

    @ContributesAndroidInjector
    abstract fun bindImageTableActivity(): ImageTableActivity
}