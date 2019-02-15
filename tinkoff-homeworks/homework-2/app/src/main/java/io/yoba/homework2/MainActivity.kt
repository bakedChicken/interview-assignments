package io.yoba.homework2

import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    companion object {
        private const val DOCUMENT_COUNT_KEY = "document-count-key"
    }

    private var documentCount = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        supportFragmentManager.addOnBackStackChangedListener {
            documentCount = supportFragmentManager.backStackEntryCount
            invalidateOptionsMenu()
        }

        if (savedInstanceState != null) {
            documentCount = savedInstanceState.getInt(DOCUMENT_COUNT_KEY)
        } else {
            supportFragmentManager.beginTransaction()
                .replace(R.id.fragment_container, DocumentFragment.newInstance(documentCount))
                .commit()
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putInt(DOCUMENT_COUNT_KEY, documentCount)
    }

    override fun onPrepareOptionsMenu(menu: Menu?): Boolean {
        if (documentCount == 0) {
            menu?.getItem(1)?.isEnabled = false
        }
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
}
