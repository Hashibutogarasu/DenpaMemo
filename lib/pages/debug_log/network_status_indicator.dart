import 'package:flutter/material.dart';

import 'package:app_logging/app_logging.dart';

/// Dedicated leading-icon widget for [NetworkLogTile]: a color/fill per
/// [NetworkLogStatus], or (when [isTimeout] is true) a clock icon in that
/// same color instead of the plain dot.
class NetworkStatusIndicator extends StatelessWidget {
  const NetworkStatusIndicator({
    super.key,
    required this.status,
    this.isTimeout = false,
    this.size = 24,
  });

  final NetworkLogStatus status;
  final bool isTimeout;
  final double size;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      NetworkLogStatus.pending => SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              ),
            ),
            SizedBox(
              width: size * 0.7,
              height: size * 0.7,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      NetworkLogStatus.success => _dot(Colors.green),
      NetworkLogStatus.error => _clockOr(Colors.red),
      NetworkLogStatus.skipped => _clockOr(Colors.grey),
      NetworkLogStatus.unchanged => _ring(Colors.green),
    };
  }

  Widget _clockOr(Color color) => isTimeout
      ? Icon(Icons.access_time, color: color, size: size)
      : _dot(color);

  Widget _dot(Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );

  Widget _ring(Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: color, width: 2),
    ),
  );
}
