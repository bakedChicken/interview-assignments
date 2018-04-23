package io.yoba.yandex.school.di

import android.app.Application
import android.arch.persistence.room.Room
import android.content.Context
import com.crashlytics.android.answers.Answers
import com.squareup.moshi.Moshi
import dagger.Module
import dagger.Provides
import io.yoba.yandex.school.AppDatabase
import io.yoba.yandex.school.BuildConfig
import io.yoba.yandex.school.data.ImageApi
import io.yoba.yandex.school.data.ImageDao
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import okhttp3.logging.HttpLoggingInterceptor.Level.BODY
import okhttp3.logging.HttpLoggingInterceptor.Level.NONE
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.moshi.MoshiConverterFactory
import javax.inject.Singleton

@Module
class AppModule {
    @Provides
    @Singleton
    fun provideContext(application: Application): Context = application

    @Provides
    @Singleton
    fun provideAnswersToLifeTheUniverseAndEverything(): Answers = Answers.getInstance()

    @Provides
    @Singleton
    fun provideMoshi(): Moshi {
        return Moshi.Builder().build()
    }

    @Provides
    @Singleton
    fun provideLoggingInterceptor() = HttpLoggingInterceptor().apply {
        level = if (BuildConfig.DEBUG) {
            BODY
        } else {
            NONE
        }
    }

    @Provides
    @Singleton
    fun provideOkHttpClientWithToken(loggingInterceptor: HttpLoggingInterceptor) = OkHttpClient.Builder()
        .addInterceptor(loggingInterceptor)
        .build()

    @Provides
    @Singleton
    fun provideRetrofitWithToken(okHttpClient: OkHttpClient, moshi: Moshi) =
        Retrofit.Builder()
            .baseUrl(BuildConfig.SERVER_URL)
            .client(okHttpClient)
            .addConverterFactory(MoshiConverterFactory.create(moshi))
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .build()

    @Provides
    @Singleton
    fun provideImageApi(retrofit: Retrofit) = retrofit.create(ImageApi::class.java)

    @Provides
    @Singleton
    fun provideApplicationDatabase(context: Context): AppDatabase = Room
        .databaseBuilder(context, AppDatabase::class.java, "images")
        .build()

    @Provides
    @Singleton
    fun provideImageDao(appDatabase: AppDatabase): ImageDao = appDatabase.imageDao()
}