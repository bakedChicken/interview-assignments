package io.yoba.tinkoff.converter

import android.app.Application
import com.crashlytics.android.Crashlytics
import io.fabric.sdk.android.Fabric
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import org.koin.android.ext.android.startKoin
import org.koin.androidx.viewmodel.ext.koin.viewModel
import org.koin.dsl.module.module
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory

class MainApplication : Application() {
    private val appModule = module {
        single { createOkHttpClient() }
        single { createRetrofit(get()) }
        single { createWebService<ConverterApi>(get()) }
        single { ConverterRepository(get()) }
        viewModel { ConverterActivityViewModel(get()) }
    }

    private fun createOkHttpClient(): OkHttpClient {
        val httpLoggingInterceptor = HttpLoggingInterceptor()
        httpLoggingInterceptor.level = HttpLoggingInterceptor.Level.BODY
        return OkHttpClient.Builder()
            .addNetworkInterceptor(httpLoggingInterceptor)
            .build()
    }

    private fun createRetrofit(okHttpClient: OkHttpClient): Retrofit {
        return Retrofit.Builder()
            .baseUrl(BuildConfig.API_URL)
            .client(okHttpClient)
            .addConverterFactory(GsonConverterFactory.create())
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .build()
    }

    private inline fun <reified T> createWebService(retrofit: Retrofit): T {
        return retrofit.create(T::class.java)
    }

    override fun onCreate() {
        super.onCreate()

        Fabric.with(this, Crashlytics())
        startKoin(this, listOf(appModule))
    }
}