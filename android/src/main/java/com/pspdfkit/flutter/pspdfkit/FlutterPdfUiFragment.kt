package com.pspdfkit.flutter.pspdfkit

import android.os.Bundle
import android.view.WindowManager
import com.pspdfkit.annotations.measurements.MeasurementPrecision
import com.pspdfkit.annotations.measurements.Scale
import com.pspdfkit.document.PdfDocument
import com.pspdfkit.ui.PdfUiFragment

class FlutterPdfUiFragment : PdfUiFragment() {

    private var scale: Scale? = null
    private var precision: MeasurementPrecision? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        this.activity?.window?.addFlags(WindowManager.LayoutParams.FLAG_SECURE or WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        EventDispatcher.getInstance().notifyActivityOnCreate()
    }

    override fun onPause() {
        super.onPause()
        EventDispatcher.getInstance().notifyActivityOnPause()
    }

    override fun onResume() {
        super.onResume()
        EventDispatcher.getInstance().notifyActivityOnResume()
    }

    override fun onDestroy() {
        super.onDestroy()
        EventDispatcher.getInstance().notifyActivityOnDestroy()
    }

    override fun onDocumentLoaded(document: PdfDocument) {
        super.onDocumentLoaded(document)
        // Notify the Flutter PSPDFKit plugin that the document has been loaded.
        EventDispatcher.getInstance().notifyDocumentLoaded(document)
        // We can register interest in newly created annotations
        // so we can easily pick up measurement information.
        if (scale != null) {
            document.measurementScale = scale
        }
        if (precision != null) {
            document.measurementPrecision = precision
        }
    }

    fun setMeasurementScale(scale: Scale?) {
        this.scale = scale
    }

    fun setMeasurementPrecision(precision: MeasurementPrecision?) {
        this.precision = precision
    }

}