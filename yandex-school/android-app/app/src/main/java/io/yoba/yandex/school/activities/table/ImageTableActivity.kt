package io.yoba.yandex.school.activities.table

import android.arch.lifecycle.Observer
import android.arch.lifecycle.ViewModelProviders
import android.databinding.DataBindingUtil
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import dagger.android.AndroidInjection
import io.yoba.yandex.school.R
import io.yoba.yandex.school.databinding.ActivityImageTableBinding
import org.jetbrains.anko.longToast
import javax.inject.Inject

class ImageTableActivity : AppCompatActivity() {
    @Inject
    lateinit var viewModelFactory: ImageTableActivityViewModelFactory

    private val viewModel by lazy {
        ViewModelProviders.of(this, viewModelFactory).get(ImageTableActivityViewModel::class.java)
    }

    private val binding by lazy {
        DataBindingUtil.setContentView<ActivityImageTableBinding>(this, R.layout.activity_image_table)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)

        binding.viewModel = viewModel

        setupBindingSubscriptions()
        setupViewModelSubscriptions()
    }

    private fun setupBindingSubscriptions() {
        binding.imageTableActivitySwipeRefreshLayout.setOnRefreshListener {
            viewModel.refreshData()
        }
    }

    private fun setupViewModelSubscriptions() {
        viewModel.restoreState(this)

        viewModel.getRefreshLiveData().observe(this, Observer {
            binding.imageTableActivitySwipeRefreshLayout.isRefreshing = false

            if (it != null) {
                longToast(it)
            }
        })
    }
}