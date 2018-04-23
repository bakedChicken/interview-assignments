package io.yoba.yandex.school.activities.table

import android.arch.lifecycle.LiveData
import android.arch.lifecycle.ViewModel
import android.content.Context
import android.databinding.ObservableBoolean
import com.stfalcon.frescoimageviewer.ImageViewer
import io.reactivex.disposables.CompositeDisposable
import io.yoba.yandex.school.BR
import io.yoba.yandex.school.R
import io.yoba.yandex.school.activities.OnImageClickListener
import io.yoba.yandex.school.data.entities.Image
import io.yoba.yandex.school.interactors.DatabaseInteractor
import io.yoba.yandex.school.interactors.NetworkInteractor
import io.yoba.yandex.school.managers.ResourceManager
import io.yoba.yandex.school.utils.NetworkError
import io.yoba.yandex.school.utils.SingleLiveEvent
import io.yoba.yandex.school.utils.extensions.switchIfValueIsEmpty
import io.yoba.yandex.school.utils.mapThrowableToNetworkError
import me.tatarka.bindingcollectionadapter2.ItemBinding
import me.tatarka.bindingcollectionadapter2.collections.DiffObservableList

class ImageTableActivityViewModel(
    private val networkInteractor: NetworkInteractor,
    private val databaseInteractor: DatabaseInteractor,
    private val resourceManager: ResourceManager
) : ViewModel(), OnImageClickListener {
    val isImageTableVisible = ObservableBoolean(false)

    val isCacheLoading = ObservableBoolean(true)

    val images = DiffObservableList(ImageObservableCallback())

    val itemBinding = ItemBinding.of<Image> { binding, _, item ->
        binding.set(BR.image, R.layout.item_image)
        binding.bindExtra(BR.image, item)
        binding.bindExtra(BR.onImageClickListener, this)
    }

    fun restoreState(context: Context) {
        showImage(context)
    }

    fun getRefreshLiveData(): LiveData<String> = refreshLiveData

    fun refreshData() {
        cs.add(networkInteractor.getImages().subscribe(this::handleImages, this::handleError))
    }

    override fun onClick(context: Context, image: Image) {
        openedImage = image
        showImage(context)
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

    private var openedImage: Image? = null

    private fun showImage(context: Context) {
        if (openedImage != null) {
            ImageViewer.Builder(context, images)
                .setFormatter { it.url }
                .setStartPosition(images.indexOf(openedImage))
                .setOnDismissListener {
                    openedImage = null
                }
                .build()
                .show()
        }
    }

    private val refreshLiveData = SingleLiveEvent<String>()

    private val cacheSubscription = databaseInteractor.getAllImages()
        .switchIfValueIsEmpty { networkInteractor.getImages() }
        .doOnSubscribe { isCacheLoading.set(true) }
        .doAfterTerminate { isCacheLoading.set(false) }
        .subscribe { cachedImages ->
            isImageTableVisible.set(cachedImages.isNotEmpty())
            images.update(cachedImages)
        }

    private val cs = CompositeDisposable(cacheSubscription)

    override fun onCleared() {
        cs.dispose()
    }
}