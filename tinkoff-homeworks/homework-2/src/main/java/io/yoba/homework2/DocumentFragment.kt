package io.yoba.homework2

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment

class DocumentFragment : Fragment() {
    companion object {
        private const val DOCUMENT_NUMBER_KEY = "document-number-key"

        fun newInstance(documentNumber: Int): DocumentFragment {
            return DocumentFragment().apply {
                arguments = bundleOf(DOCUMENT_NUMBER_KEY to documentNumber)
            }
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val view = inflater.inflate(R.layout.fragment_document, container, false)

        val textView = view.findViewById<TextView>(R.id.document_fragment_document_number_text_view)
        textView.text = getString(R.string.document_fragment_document_name_text, arguments?.getInt(DOCUMENT_NUMBER_KEY))

        return view
    }
}