import 'dart:io';

/// Whether the current process is running on Linux without an X11 or
/// Wayland display server available (e.g. a headless session or a
/// container) — `DISPLAY` and `WAYLAND_DISPLAY` are both unset. Always
/// false on any platform other than Linux.
bool isLinuxWithoutDisplay() =>
    Platform.isLinux &&
    Platform.environment['DISPLAY'] == null &&
    Platform.environment['WAYLAND_DISPLAY'] == null;
