package io.yoba.yandex.school.activities.start

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import com.crashlytics.android.answers.Answers
import com.crashlytics.android.answers.CustomEvent
import dagger.android.AndroidInjection
import io.yoba.yandex.school.activities.table.ImageTableActivity
import org.jetbrains.anko.startActivity
import javax.inject.Inject

class StartActivity : AppCompatActivity() {
    @Inject
    lateinit var answers: Answers

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)

        answers.logCustom(CustomEvent("Application started"))
        startActivity<ImageTableActivity>()
        finish()
    }
}