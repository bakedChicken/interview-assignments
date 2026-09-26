package io.yoba.yandex.school.activities

import android.content.Context
import io.yoba.yandex.school.data.entities.Image

interface OnImageClickListener {
    fun onClick(context: Context, image: Image)
}