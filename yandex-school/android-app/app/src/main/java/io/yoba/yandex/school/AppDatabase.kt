package io.yoba.yandex.school

import android.arch.persistence.room.Database
import android.arch.persistence.room.RoomDatabase
import io.yoba.yandex.school.data.ImageDao
import io.yoba.yandex.school.data.entities.Image

@Database(entities = [Image::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun imageDao(): ImageDao
}