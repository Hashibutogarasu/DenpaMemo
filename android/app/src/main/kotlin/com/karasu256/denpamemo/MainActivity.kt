package com.karasu256.denpamemo

import android.content.Context
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import android.view.ContextThemeWrapper
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache

/**
 * Reuses the engine [DenpaMemoApplication] started at process launch instead
 * of creating a fresh one, and overlays a native splash view on top of the
 * Flutter content until the main screen reports ready, shown for at least
 * [MIN_VISIBLE_MS] and at most [MAX_WAIT_MS]. The splash lives inside this
 * same activity/window rather than a separate launcher activity, so the
 * handoff can't surface as a distinct activity on OS versions whose window
 * manager makes activity transitions visible.
 */
class MainActivity : FlutterActivity() {
    private var splashView: View? = null
    private var continued = false
    private var scheduled = false
    private var startedAt = 0L

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return FlutterEngineCache.getInstance().get(DenpaMemoApplication.MAIN_ENGINE_ID)
            ?: super.provideFlutterEngine(context)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        startedAt = SystemClock.elapsedRealtime()

        val overlayContext = ContextThemeWrapper(this, R.style.SplashOverlayTheme)
        val overlay =
            LayoutInflater.from(overlayContext).inflate(R.layout.activity_splash, null)
        addContentView(
            overlay,
            ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT,
            ),
        )
        splashView = overlay

        if (DenpaMemoApplication.isMainScreenReady) {
            scheduleFadeOut()
        } else {
            DenpaMemoApplication.onMainScreenReady = { scheduleFadeOut() }
            Handler(Looper.getMainLooper()).postDelayed({ scheduleFadeOut() }, MAX_WAIT_MS)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        DenpaMemoApplication.onMainScreenReady = null
    }

    private fun scheduleFadeOut() {
        if (scheduled) return
        scheduled = true
        val remaining = MIN_VISIBLE_MS - (SystemClock.elapsedRealtime() - startedAt)
        Handler(Looper.getMainLooper())
            .postDelayed({ fadeOutSplash() }, remaining.coerceAtLeast(0))
    }

    private fun fadeOutSplash() {
        if (continued) return
        continued = true
        val view = splashView ?: return
        view.animate()
            .alpha(0f)
            .setDuration(FADE_OUT_DURATION_MS)
            .withEndAction {
                (view.parent as? ViewGroup)?.removeView(view)
                splashView = null
            }
            .start()
    }

    private companion object {
        const val FADE_OUT_DURATION_MS = 400L
        const val MIN_VISIBLE_MS = 1200L
        const val MAX_WAIT_MS = 10000L
    }
}
