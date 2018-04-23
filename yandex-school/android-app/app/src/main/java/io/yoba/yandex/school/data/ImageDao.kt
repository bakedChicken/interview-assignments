package io.yoba.yandex.school.data

import android.arch.persistence.room.Dao
import android.arch.persistence.room.Insert
import android.arch.persistence.room.OnConflictStrategy
import android.arch.persistence.room.Query
import io.reactivex.Single
import io.yoba.yandex.school.data.entities.Image

@Dao
interface ImageDao {
    @Query("SELECT * FROM Image")
    fun getAll(): Single<List<Image>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun saveAll(images: List<Image>)

    @Query("DELETE FROM Image")
    fun deleteAll()
}