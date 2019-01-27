package io.yoba.tinkoff.converter

import android.os.Bundle
import android.widget.ArrayAdapter
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
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

        binding.converterActivityFromCurrencyEditText.setOnFocusChangeListener { v, hasFocus ->
            if (hasFocus) {
                viewModel.field.set(Field.FROM)
            }
        }

        binding.converterActivityToCurrencyEditText.setOnFocusChangeListener { v, hasFocus ->
            if (hasFocus) {
                viewModel.field.set(Field.TO)
            }
        }

        viewModel.getCurrenciesLiveData().observe(this, Observer {
            val adapter = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, it.map { currency -> currency.id })
            binding.converterActivityFromCurrencySpinner.adapter = adapter
            binding.converterActivityToCurrencySpinner.adapter = adapter
        })
    }
}
