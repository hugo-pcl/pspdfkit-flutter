package com.pspdfkit.flutter.pspdfkit

///  Copyright © 2021-2023 PSPDFKit GmbH. All rights reserved.
///
///  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
///  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
///  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
///  This notice may not be removed from this file.
///

import android.os.Bundle
import android.view.WindowManager
import com.pspdfkit.document.PdfDocument
import com.pspdfkit.instant.document.InstantPdfDocument
import com.pspdfkit.instant.exceptions.InstantException
import com.pspdfkit.instant.ui.InstantPdfActivity
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.atomic.AtomicReference

/**
 * For communication with the PSPDFKit plugin, we keep a static reference to the current
 * activity.
 */
class FlutterInstantPdfActivity : InstantPdfActivity() {
    override fun onCreate(bundle: Bundle?) {
        super.onCreate(bundle)
        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE or WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        EventDispatcher.getInstance().notifyActivityOnCreate()
        bindActivity()
    }

    override fun onPause() {
        super.onPause()
        // Notify the Flutter PSPDFKit plugin that the activity is going to enter the onPause state.
        EventDispatcher.getInstance().notifyActivityOnPause()
    }

    override fun onResume() {
        super.onResume()
        EventDispatcher.getInstance().notifyActivityOnResume()
    }

    override fun onDestroy() {
        super.onDestroy()
        EventDispatcher.getInstance().notifyActivityOnDestroy()
        releaseActivity()
    }
    
    override fun onDocumentLoaded(pdfDocument: PdfDocument) {
        super.onDocumentLoaded(pdfDocument)
        // Notify the Flutter PSPDFKit plugin that the document has been loaded.
        EventDispatcher.getInstance().notifyDocumentLoaded(pdfDocument)
        val result = loadedDocumentResult.getAndSet(null)
        result?.success(true)
    }

    override fun onDocumentLoadFailed(throwable: Throwable) {
        super.onDocumentLoadFailed(throwable)
        val result = loadedDocumentResult.getAndSet(null)
        result?.success(false)
    }
    
    override fun onSyncStarted(instantDocument: InstantPdfDocument) {
        super.onSyncStarted(instantDocument)
        EventDispatcher.getInstance()
            .notifyInstantSyncStarted(instantDocument.instantDocumentDescriptor.documentId)
    }

    override fun onSyncFinished(instantDocument: InstantPdfDocument) {
        super.onSyncFinished(instantDocument)
        EventDispatcher.getInstance()
            .notifyInstantSyncFinished(instantDocument.instantDocumentDescriptor.documentId)
    }

    override fun onSyncError(instantDocument: InstantPdfDocument, error: InstantException) {
        super.onSyncError(instantDocument, error)
        EventDispatcher.getInstance().notifyInstantSyncFailed(
            instantDocument.instantDocumentDescriptor.documentId,
            error.message
        )
    }

    override fun onAuthenticationFinished(instantDocument: InstantPdfDocument, validJwt: String) {
        super.onAuthenticationFinished(instantDocument, validJwt)
        EventDispatcher.getInstance().notifyInstantAuthenticationFinished(
            instantDocument.instantDocumentDescriptor.documentId,
            validJwt
        )
    }

    override fun onAuthenticationFailed(
        instantDocument: InstantPdfDocument,
        error: InstantException
    ) {
        super.onAuthenticationFailed(instantDocument, error)
        EventDispatcher.getInstance().notifyInstantAuthenticationFailed(
            instantDocument.instantDocumentDescriptor.documentId,
            error.message
        )
    }

    private fun bindActivity() {
        currentActivity = this
    }

    private fun releaseActivity() {
        val result = loadedDocumentResult.getAndSet(null)
        result?.success(false)
        currentActivity = null
    }

    companion object {

        @JvmStatic
        var currentActivity: FlutterInstantPdfActivity? = null
            private set
        private val loadedDocumentResult = AtomicReference<MethodChannel.Result?>()


        @JvmStatic
        fun setLoadedDocumentResult(result: MethodChannel.Result?) {
            loadedDocumentResult.set(result)
        }
    }
}