package io.yoba.yandex.school.activities.table

import android.arch.lifecycle.ViewModel
import android.arch.lifecycle.ViewModelProvider
import io.yoba.yandex.school.interactors.DatabaseInteractor
import io.yoba.yandex.school.interactors.NetworkInteractor
import io.yoba.yandex.school.managers.ResourceManager
import javax.inject.Inject

class ImageTableActivityViewModelFactory @Inject constructor(
    val networkInteractor: NetworkInteractor,
    val databaseInteractor: DatabaseInteractor,
    val resourceManager: ResourceManager
) : ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        @Suppress("UNCHECKED_CAST")
        return ImageTableActivityViewModel(networkInteractor, databaseInteractor, resourceManager) as T
    }
}