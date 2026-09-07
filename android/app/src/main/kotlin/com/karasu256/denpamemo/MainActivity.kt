package com.karasu256.denpamemo

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache

/**
 * Reuses the engine [DenpaMemoApplication] started at process launch
 * instead of creating a fresh one, so [SplashActivity] handing off here
 * shows the already-initialized app rather than booting Flutter a second
 * time.
 */
class MainActivity : FlutterActivity() {
    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return FlutterEngineCache.getInstance().get(DenpaMemoApplication.MAIN_ENGINE_ID)
            ?: super.provideFlutterEngine(context)
    }
}
