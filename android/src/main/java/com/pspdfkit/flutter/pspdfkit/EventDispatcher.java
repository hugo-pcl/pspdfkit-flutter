///
///  Copyright © 2021-2023 PSPDFKit GmbH. All rights reserved.
///
///  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
///  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
///  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
///  This notice may not be removed from this file.
///

package com.pspdfkit.flutter.pspdfkit;

import android.os.Handler;
import android.os.Looper;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import android.util.Log;

import com.pspdfkit.document.PdfDocument;

import org.jetbrains.annotations.NotNull;

import java.util.HashMap;

import io.flutter.plugin.common.MethodChannel;

/**
 * Internal singleton class used to communicate between activities and the PSPDFKit Flutter plugin.
 */
public class EventDispatcher {
    public interface EventDispatcherListener {
        void triggerEvent(@NonNull final String method, @Nullable final Object arguments);
    }

    @Nullable
    private static EventDispatcher instance;
    /**
     * A channel for sending events from Java to Flutter. This is set as soon as
     * the plugin is registered.
     */
    @Nullable
    private MethodChannel channel = null;
    
    private EventDispatcherListener listener;

    private EventDispatcher() {
    }

    @NonNull
    public static synchronized EventDispatcher getInstance() {
        if (instance == null) {
            instance = new EventDispatcher();
        }
        return instance;
    }

    private final Handler uiThreadHandler = new Handler(Looper.getMainLooper());

    public void setDispatcherListener(EventDispatcherListener listener) {
        this.listener = listener;
    }
    
    public void setChannel(@Nullable MethodChannel channel) {
        this.channel = channel;
    }

    public void notifyActivityOnCreate() {
        sendEvent("flutterPdfActivityOnCreate");
    }

    public void notifyActivityOnPause() {
        sendEvent("flutterPdfActivityOnPause");
    }

    public void notifyPdfFragmentAdded() {
        sendEvent("flutterPdfFragmentAdded");
    }    

    public void notifyActivityOnResume() {
        sendEvent("flutterPdfActivityOnResume");
    }

    public void notifyActivityOnDestroy() {
        sendEvent("flutterPdfActivityOnDestroy");
    }

    public void notifyDocumentLoaded(@NotNull PdfDocument document) {
        sendEvent("pspdfkitDocumentLoaded", new HashMap<String, Object>() {{
            put("uid", document.getUid());
            put("pageCount", document.getPageCount());
        }});
    }

    public void notifyPageChanged(int oldPageIndex, int newPageIndex) {
        Log.d("##Notif", "### Page changed:"+oldPageIndex+" New page: "+newPageIndex);
        sendEvent("pspdfkitPageChanged", new HashMap<String, Integer>() {{
            put("oldPageIndex", oldPageIndex);
            put("newPageIndex", newPageIndex);
        }});
    }

    public void notifyInstantSyncStarted(String documentId) {
        sendEvent("pspdfkitInstantSyncStarted", documentId);
    }

    public void notifyInstantSyncFinished(String documentId) {
        sendEvent("pspdfkitInstantSyncFinished", documentId);
    }

    public void notifyInstantSyncFailed(String documentId, String error) {
        sendEvent("pspdfkitInstantSyncFailed",new HashMap<String, String>() {{
            put("documentId", documentId);
            put("error", error);
        }});
    }

    public void notifyInstantAuthenticationFinished(String documentId,String validJWT) {
        sendEvent("pspdfkitInstantAuthenticationFinished", new HashMap<String, String>() {{
            put("documentId", documentId);
            put("jwt", validJWT);
        }});
    }

    public void notifyInstantAuthenticationFailed(String documentId, String error) {
        sendEvent("pspdfkitInstantAuthenticationFailed", new HashMap<String, String>() {{
            put("documentId", documentId);
            put("error", error);
        }});
    }

    public void notifyBookmarkTapped() {
        sendEvent("pspdfkitBookmarkTapped");
    }

    public void notifyBookmarkAdded() {
        sendEvent("pspdfkitBookmarkAdded");
    }

    public void notifyBookmarksEdited() {
        sendEvent("pspdfkitBookmarksEdited");
    }

    public void notifyBookmarkRemoved() {
        sendEvent("pspdfkitBookmarkRemoved");
    }

    public void notifyBookmarksSorted() {
        sendEvent("pspdfkitBookmarksSorted");
    }

    public void notifyBookmarkRenamed() {
        sendEvent("pspdfkitBookmarkRenamed");
    }


    private void sendEvent(String eventName) {
        sendEvent(eventName, null);
    }

    private void sendEvent(@NonNull final String method, @Nullable final Object arguments) {
        if (this.listener != null) {
            uiThreadHandler.post(() -> this.listener.triggerEvent(method, arguments));
        }
        if (channel != null) {
            uiThreadHandler.post(() -> channel.invokeMethod(method, arguments, null));
        }
    }
}
