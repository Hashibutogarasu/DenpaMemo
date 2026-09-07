package com.karasu256.denpamemo

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

/**
 * Starts Dart's `main()` the moment the OS process starts, registering
 * its `ready` method channel handler before the entrypoint runs so a
 * fast, debugger-free startup can't fire it before [MainActivity]
 * exists to observe [isMainScreenReady] or [onMainScreenReady].
 */
class DenpaMemoApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        val engine = FlutterEngine(this)
        MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL_NAME)
            .setMethodCallHandler { call, result ->
                if (call.method == "ready") {
                    isMainScreenReady = true
                    onMainScreenReady?.invoke()
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
        engine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache.getInstance().put(MAIN_ENGINE_ID, engine)
    }

    companion object {
        const val MAIN_ENGINE_ID = "main_engine"
        private const val CHANNEL_NAME = "com.karasu256.denpamemo/splash"

        @Volatile
        var isMainScreenReady: Boolean = false
            private set

        @Volatile
        var onMainScreenReady: (() -> Unit)? = null
    }
}
