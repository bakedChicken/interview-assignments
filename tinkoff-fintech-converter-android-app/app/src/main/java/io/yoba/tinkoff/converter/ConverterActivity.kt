package io.yoba.tinkoff.converter

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import io.yoba.tinkoff.converter.databinding.ActivityConverterBinding
import org.koin.androidx.viewmodel.ext.android.viewModel

class ConverterActivity : AppCompatActivity() {
    private val viewModel by viewModel<ConverterActivityViewModel>()

    private val binding by lazy {
        DataBindingUtil.setContentView<ActivityConverterBinding>(this, R.layout.activity_converter)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding.viewModel = viewModel
    }
}