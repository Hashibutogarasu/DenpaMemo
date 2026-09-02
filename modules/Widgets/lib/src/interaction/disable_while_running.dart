import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Disables [builder]'s callback the instant it's pressed, ahead of
/// [provider] catching up to report it running, and re-enables it once
/// [provider] reports `false` again.
class DisableWhileRunning extends ConsumerStatefulWidget {
  const DisableWhileRunning({
    super.key,
    required this.provider,
    required this.onPressed,
    required this.builder,
  });

  final Provider<bool> provider;
  final VoidCallback onPressed;
  final Widget Function(BuildContext context, VoidCallback? onPressed) builder;

  @override
  ConsumerState<DisableWhileRunning> createState() => _DisableWhileRunningState();
}

class _DisableWhileRunningState extends ConsumerState<DisableWhileRunning> {
  var _pressedLocally = false;

  void _handlePressed() {
    setState(() => _pressedLocally = true);
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final running = ref.watch(widget.provider);
    ref.listen<bool>(widget.provider, (previous, isRunning) {
      if (!isRunning) setState(() => _pressedLocally = false);
    });
    final disabled = running || _pressedLocally;
    return widget.builder(context, disabled ? null : _handlePressed);
  }
}
