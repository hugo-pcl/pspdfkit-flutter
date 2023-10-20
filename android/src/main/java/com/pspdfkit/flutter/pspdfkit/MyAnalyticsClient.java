package com.pspdfkit.flutter.pspdfkit;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.pspdfkit.analytics.Analytics;
import com.pspdfkit.analytics.AnalyticsClient;
import org.jetbrains.annotations.NotNull;

public class MyAnalyticsClient implements AnalyticsClient {
    @Override
    public void onEvent(@NonNull @NotNull String s, @Nullable @org.jetbrains.annotations.Nullable Bundle bundle) {
       if (s.equals(Analytics.Event.CHANGE_PAGE)) {
           assert bundle != null;
           EventDispatcher.getInstance().notifyChangePage(
                bundle.getInt(Analytics.Data.PAGE_INDEX),
                bundle.getInt(Analytics.Data.TARGET_PAGE_INDEX)
          );
       }
    }
}
