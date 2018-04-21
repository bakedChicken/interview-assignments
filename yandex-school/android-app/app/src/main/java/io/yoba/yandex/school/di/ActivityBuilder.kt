package io.yoba.yandex.school.di

import dagger.Module
import dagger.android.ContributesAndroidInjector
import io.yoba.yandex.school.activities.StartActivity

@Module
abstract class ActivityBuilder {
    @ContributesAndroidInjector
    abstract fun bindStartActivity(): StartActivity
}