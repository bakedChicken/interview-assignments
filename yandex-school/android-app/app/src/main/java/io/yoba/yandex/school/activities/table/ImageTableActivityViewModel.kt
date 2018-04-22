package io.yoba.yandex.school.activities.table

import android.arch.lifecycle.LiveData
import android.arch.lifecycle.ViewModel
import android.databinding.ObservableBoolean
import io.reactivex.disposables.CompositeDisposable
import io.yoba.yandex.school.BR
import io.yoba.yandex.school.R
import io.yoba.yandex.school.data.entities.Image
import io.yoba.yandex.school.interactors.NetworkInteractor
import io.yoba.yandex.school.managers.ResourceManager
import io.yoba.yandex.school.utils.NetworkError
import io.yoba.yandex.school.utils.SingleLiveEvent
import io.yoba.yandex.school.utils.mapThrowableToNetworkError
import me.tatarka.bindingcollectionadapter2.ItemBinding
import me.tatarka.bindingcollectionadapter2.collections.DiffObservableList

class ImageTableActivityViewModel(
    private val networkInteractor: NetworkInteractor,
    private val resourceManager: ResourceManager
) : ViewModel() {
    val isImageTableVisible = ObservableBoolean(false)

    val images = DiffObservableList(ImageObservableCallback())

    val itemBinding = ItemBinding.of<Image> { binding, _, item ->
        binding.set(BR.image, R.layout.item_image)
        binding.bindExtra(BR.image, item)
    }

    fun getRefreshLiveData(): LiveData<String> = refreshLiveData

    fun refreshData() {
        cs.add(networkInteractor.getImages().subscribe(this::handleImages, this::handleError))
    }

    private fun handleImages(networkImages: List<Image>) {
        isImageTableVisible.set(networkImages.isNotEmpty())
        images.update(networkImages)
        refreshLiveData.call()
    }

    private fun handleError(throwable: Throwable) {
        refreshLiveData.value = when (mapThrowableToNetworkError(throwable)) {
            is NetworkError.ServerIsUnavailable,
            is NetworkError.BadGateway ->
                resourceManager[R.string.image_table_activity_server_is_unavailable_error]
            is NetworkError.NoInternetConnection ->
                resourceManager[R.string.image_table_activity_no_internet_connection_error]
            else ->
                resourceManager[R.string.image_table_activity_unknown_error]
        }
    }

    private val refreshLiveData = SingleLiveEvent<String>()

    private val cs = CompositeDisposable()

    override fun onCleared() {
        cs.dispose()
    }
}