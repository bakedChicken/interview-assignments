package io.yoba.homework2

import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.FragmentManager

class MainActivity : AppCompatActivity() {
    private val documentCount
        get() = supportFragmentManager.backStackEntryCount

    private val backStackListener = FragmentManager.OnBackStackChangedListener {
        invalidateOptionsMenu()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .replace(R.id.fragment_container, DocumentFragment.newInstance(documentCount))
                .commit()
        }

        supportFragmentManager.addOnBackStackChangedListener(backStackListener)
    }

    override fun onPrepareOptionsMenu(menu: Menu?): Boolean {
        menu?.findItem(R.id.remove_fragment_button)?.isEnabled = documentCount > 0
        return super.onPrepareOptionsMenu(menu)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.main, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem?): Boolean {
        val id = item?.itemId

        return when (id) {
            R.id.add_fragment_button -> {
                supportFragmentManager
                    .beginTransaction()
                    .replace(R.id.fragment_container, DocumentFragment.newInstance(documentCount + 1))
                    .addToBackStack(null)
                    .commit()
                true
            }
            R.id.remove_fragment_button -> {
                supportFragmentManager.popBackStack()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    override fun onDestroy() {
        supportFragmentManager.removeOnBackStackChangedListener(backStackListener)
        super.onDestroy()
    }
}
