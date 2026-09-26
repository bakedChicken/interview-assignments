package io.yoba.yandex.school.data.entities

import android.arch.persistence.room.ColumnInfo
import android.arch.persistence.room.Entity
import android.arch.persistence.room.PrimaryKey

@Entity
data class Image(
    @PrimaryKey
    var id: Long = 0,

    @ColumnInfo(name = "image_name")
    var name: String = "",

    @ColumnInfo(name = "image_url")
    var url: String = ""
)