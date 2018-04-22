package io.yoba.yandex.school.activities.table

import io.yoba.yandex.school.data.entities.Image
import me.tatarka.bindingcollectionadapter2.collections.DiffObservableList

class ImageObservableCallback : DiffObservableList.Callback<Image> {
    override fun areItemsTheSame(oldItem: Image?, newItem: Image?): Boolean {
        return oldItem?.id == newItem?.id
    }

    override fun areContentsTheSame(oldItem: Image?, newItem: Image?): Boolean {
        return oldItem?.url == newItem?.url
    }
}