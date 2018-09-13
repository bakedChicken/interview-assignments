package io.yoba.tinkoff.converter;

import android.view.View;

import androidx.databinding.BindingAdapter;

// Пришлось написать биндинги на Java, потому что версия на Котлине не компилировалась с symbol not found.
// Возможно, это проблема альфа версий и canary сборок, но мне уже лень переделывать :(
public class BindingAdapters {
//    @BindingAdapter("visible")
//    fun setVisibility(view: View, visible: Boolean) {
//        view.visibility = if (visible) View.VISIBLE else View.GONE
//    }

    @BindingAdapter("visible")
    public static void setVisibility(View view, boolean visible) {
        view.setVisibility(visible ? View.VISIBLE : View.GONE);
    }
}
