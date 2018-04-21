package io.yoba.yandex.school.di

import android.app.Application
import android.content.Context
import com.crashlytics.android.answers.Answers
import dagger.Module
import dagger.Provides
import javax.inject.Singleton

@Module
class AppModule {
    @Provides
    @Singleton
    fun provideContext(application: Application): Context = application

    @Provides
    @Singleton
    fun provideAnswersToLifeTheUniverseAndEverything(): Answers = Answers.getInstance()
}