package io.yoba.yandex.school.activities

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import com.crashlytics.android.answers.Answers
import com.crashlytics.android.answers.CustomEvent
import dagger.android.AndroidInjection
import io.yoba.yandex.school.interactors.NetworkInteractor
import javax.inject.Inject

class StartActivity : AppCompatActivity() {
    @Inject
    lateinit var answers: Answers

    @Inject
    lateinit var networkInteractor: NetworkInteractor

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)

        answers.logCustom(CustomEvent("Application started"))

        networkInteractor.getImages().subscribe { it ->
            Log.e("StartActivity", "$it")
        }
    }
}