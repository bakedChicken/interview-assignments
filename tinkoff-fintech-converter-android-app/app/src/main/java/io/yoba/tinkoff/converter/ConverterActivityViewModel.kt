package io.yoba.tinkoff.converter

import androidx.databinding.ObservableBoolean
import androidx.databinding.ObservableField
import androidx.lifecycle.ViewModel
import com.crashlytics.android.Crashlytics
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers
import retrofit2.HttpException
import java.net.SocketTimeoutException
import java.net.UnknownHostException

class ConverterActivityViewModel(private val converterRepository: ConverterRepository) : ViewModel() {
    val isLoading = ObservableBoolean(false)
    val fromCurrency = ObservableField("")
    val toCurrency = ObservableField("")
    val convertionResult = ObservableField("")
    val error = ObservableField("")

    fun convert() {
        error.set("")
        if (fromCurrency.get() == toCurrency.get()) {
            convertionResult.set("1")
            return
        }

        cd.add(converterRepository.convertCurrencies(fromCurrency.get()!!, toCurrency.get()!!)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .doOnSubscribe { isLoading.set(true) }
            .doAfterTerminate { isLoading.set(false) }
            .subscribe({ result ->
                if (result.isNullOrEmpty()) {
                    error.set("Такая пара валют не найдена")
                } else {
                    convertionResult.set(result)
                }
            }, this::handleError))
    }

    private fun handleError(throwable: Throwable) {
        when (throwable) {
            is HttpException -> {
                // Если сервер упал и вернул 500 – мы ничего не можем сделать
                // Если сервер вернул 404 – мы провалили интеграцию с сервисом
                // Если сервер вернул 403 – мы провалили интеррацию с сервисом
                // Если сервер вернул 401 – мы провалили интеграцию с сервисом
                // Если сервер вернул 400 – мы провалили интеграцию с сервисом
                // Но сервис все равно не вернет 4**, потому что сервис ужасен
                Crashlytics.logException(throwable)
                error.set("Произошла неизвестная ошибка")
            }
            is UnknownHostException, is SocketTimeoutException -> {
                error.set("Отсутсвует соединение с интернетом")
            }
        }
    }

    private val cd = CompositeDisposable()

    override fun onCleared() {
        cd.dispose()
    }
}