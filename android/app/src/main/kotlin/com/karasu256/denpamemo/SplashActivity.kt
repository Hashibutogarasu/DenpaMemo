package com.karasu256.denpamemo

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import android.view.View

/**
 * This app's launcher activity: a native equivalent of the Flutter-drawn
 * splash, shown for at least [MIN_VISIBLE_MS] even if
 * [DenpaMemoApplication] already reports the main screen ready, and at
 * most [MAX_WAIT_MS] if it never does.
 */
class SplashActivity : Activity() {
    private var continued = false
    private var scheduled = false
    private var startedAt = 0L

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)
        startedAt = SystemClock.elapsedRealtime()

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
            .postDelayed({ fadeOutAndContinue() }, remaining.coerceAtLeast(0))
    }

    private fun fadeOutAndContinue() {
        if (continued) return
        continued = true
        val root: View = findViewById(R.id.splashRoot)
        root.animate()
            .alpha(0f)
            .setDuration(FADE_OUT_DURATION_MS)
            .withEndAction { startMainActivity() }
            .start()
    }

    private fun startMainActivity() {
        startActivity(Intent(this, MainActivity::class.java))
        overridePendingTransition(0, 0)
        finish()
    }

    private companion object {
        const val FADE_OUT_DURATION_MS = 400L
        const val MIN_VISIBLE_MS = 1200L
        const val MAX_WAIT_MS = 10000L
    }
}
