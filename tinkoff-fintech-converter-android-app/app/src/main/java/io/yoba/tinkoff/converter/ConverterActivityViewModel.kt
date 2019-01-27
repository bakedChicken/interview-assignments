package io.yoba.tinkoff.converter

import androidx.databinding.Observable
import androidx.databinding.ObservableBoolean
import androidx.databinding.ObservableField
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.crashlytics.android.Crashlytics
import io.reactivex.BackpressureStrategy
import io.reactivex.Flowable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.rxkotlin.Flowables
import io.reactivex.schedulers.Schedulers
import retrofit2.HttpException
import java.net.SocketTimeoutException
import java.net.UnknownHostException
import java.text.DecimalFormat

enum class Field {
    FROM, TO
}

class ConverterActivityViewModel(private val converterRepository: ConverterRepository) : ViewModel() {
    val isLoading = ObservableBoolean(false)
    val fromCurrencyName = ObservableField("")
    val toCurrencyName = ObservableField("")
    val fromCurrency = ObservableField("0")
    val toCurrency = ObservableField("0")
    val field = ObservableField(Field.FROM)
    val error = ObservableField("")

    fun getCurrenciesLiveData(): LiveData<List<Currency>> {
        return currenciesLiveData
    }

    private val currenciesSubscription = converterRepository.getCurrencies()
        .subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())
        .doOnSubscribe { isLoading.set(true) }
        .doAfterTerminate { isLoading.set(false) }
        .subscribe({
            currenciesLiveData.value = it
        }, this::handleError)

    private val currenciesLiveData = MutableLiveData<List<Currency>>()

    private val currencyNameSubscription = Flowables.combineLatest(
        fromCurrencyName.asFlowable(),
        toCurrencyName.asFlowable(),
        fromCurrency.asFlowable(),
        toCurrency.asFlowable()
    ) { from, to, fromCurrency, toCurrency ->
        Pair(Pair(from, to), Pair(fromCurrency, toCurrency))
    }
        .observeOn(Schedulers.io())
        .flatMapSingle { (names, counts) ->
            when (field.get()!!) {
                Field.FROM -> converterRepository.convertCurrencies(names.first, names.second, counts.first?.toDoubleOrNull())
                Field.TO -> converterRepository.convertCurrencies(names.second, names.first, counts.second?.toDoubleOrNull())
            }.doOnSubscribe {
                isLoading.set(true)
            }.doAfterSuccess {
                isLoading.set(false)
            }.map {
                Pair(it, Pair(names, counts))
            }
        }
        .distinctUntilChanged()
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe({ (value, _) ->
            val result = DecimalFormat("#.##").format(value)
            when (field.get()!!) {
                Field.FROM -> toCurrency.set(result)
                Field.TO -> fromCurrency.set(result)
            }
        }, this::handleError)

    private val cd = CompositeDisposable(currenciesSubscription, currencyNameSubscription)

    private fun handleError(throwable: Throwable) {
        when (throwable) {
            is HttpException -> {
                Crashlytics.logException(throwable)
                error.set("Произошла неизвестная ошибка")
            }
            is UnknownHostException, is SocketTimeoutException -> {
                error.set("Отсутсвует соединение с интернетом")
            }
        }
    }

    override fun onCleared() {
        cd.dispose()
    }
}

private fun <T> ObservableField<T>.asFlowable(): Flowable<T> {
    return Flowable.create<T>({
        addOnPropertyChangedCallback(object : Observable.OnPropertyChangedCallback() {
            override fun onPropertyChanged(sender: Observable?, propertyId: Int) {
                it.onNext(get()!!)
            }
        })
    }, BackpressureStrategy.LATEST)
}
