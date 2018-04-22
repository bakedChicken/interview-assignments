package io.yoba.yandex.school.utils.bindings

import android.databinding.BindingAdapter
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.request.RequestOptions

@BindingAdapter("imageUrl")
fun setImageUrl(imageView: ImageView, imageUrl: String?) {
    if (imageUrl == null) {
        Glide.with(imageView.context).clear(imageView)
        return
    }

    Glide.with(imageView.context)
        .load(imageUrl)
        .apply(RequestOptions().diskCacheStrategy(DiskCacheStrategy.RESOURCE))
        .into(imageView)
}