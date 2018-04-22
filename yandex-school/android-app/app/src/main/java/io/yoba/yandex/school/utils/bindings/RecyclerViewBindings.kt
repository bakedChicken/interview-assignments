package io.yoba.yandex.school.utils.bindings

import android.databinding.BindingAdapter
import android.support.v7.widget.RecyclerView
import io.yoba.yandex.school.activities.CustomItemDecorators
import io.yoba.yandex.school.activities.CustomItemDecorators.GRID_SPACE
import io.yoba.yandex.school.activities.GridSpacingItemDecoration

@BindingAdapter("itemDecorator")
fun setItemDecorator(recyclerView: RecyclerView, itemDecoration: String) {
    when (CustomItemDecorators.valueOf(itemDecoration)) {
        GRID_SPACE -> {
            val decorator = GridSpacingItemDecoration(2, 10, false, 0)
            recyclerView.addItemDecoration(decorator)
        }
    }
}