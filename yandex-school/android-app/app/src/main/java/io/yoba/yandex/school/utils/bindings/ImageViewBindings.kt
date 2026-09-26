package io.yoba.yandex.school.utils.bindings

import android.databinding.BindingAdapter
import com.facebook.drawee.backends.pipeline.Fresco
import com.facebook.drawee.view.SimpleDraweeView

@BindingAdapter("imageUrl")
fun setImageUrl(imageView: SimpleDraweeView, imageUrl: String) {
    imageView.controller = Fresco.newDraweeControllerBuilder().apply {
        tapToRetryEnabled = true
        setUri(imageUrl)
    }.build()
}