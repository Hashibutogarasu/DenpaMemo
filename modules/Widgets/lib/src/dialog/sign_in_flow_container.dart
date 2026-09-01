import 'package:flutter/material.dart' hide Step;
import 'package:step_dialog/step_dialog.dart'
    show ErrorDialog, Step, StepBatch, StepRunFailure;

import '../../i18n/gen/strings.g.dart';
import '../indicator/marker.dart';

/// Backend-agnostic step-flow shell: runs a caller-built [steps] list
/// against a caller-built [stepContext] via [StepBatch.runAll], visualizing
/// each step's progress as a [Marker] row. Never dismissible by tapping
/// outside — Cancel is the only way to abort; OK enables only once the
/// last step completes.
class SignInFlowContainer<C> extends StatefulWidget {
  const SignInFlowContainer({
    super.key,
    required this.steps,
    required this.stepContext,
    required this.stepLabels,
    this.title,
    this.onCancel,
    this.onComplete,
    this.messengerKey,
  });

  final List<Step<C>> steps;
  final C stepContext;
  final List<String> stepLabels;
  final String? title;
  final VoidCallback? onCancel;
  final void Function(C stepContext)? onComplete;

  final GlobalKey<ScaffoldMessengerState>? messengerKey;

  @override
  State<SignInFlowContainer<C>> createState() => _SignInFlowContainerState<C>();
}

enum _StepStatus { pending, active, done, error }

class _SignInFlowContainerState<C> extends State<SignInFlowContainer<C>> {
  late List<_StepStatus> _statuses;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _statuses = List.generate(
      widget.steps.length,
      (index) => index == 0 ? _StepStatus.active : _StepStatus.pending,
    );
    _run();
  }

  Future<void> _run() async {
    try {
      await widget.steps.runAll(widget.stepContext, onProgress: _onProgress);
      if (!mounted) return;
      setState(() => _completed = true);
    } on StepRunFailure<C> catch (failure) {
      if (!mounted) return;
      _markActiveStepAsError();
      await ErrorDialog.show(
        context,
        title: t.common.errorTitle,
        description: '${failure.error}',
        stackTrace: failure.stackTrace,
      );
    }
  }

  void _onProgress(double? progress) {
    if (!mounted || progress == null) return;
    final completedCount = (progress * widget.steps.length).round();
    setState(() {
      for (var i = 0; i < _statuses.length; i++) {
        if (i < completedCount) {
          _statuses[i] = _StepStatus.done;
        } else if (i == completedCount) {
          _statuses[i] = _StepStatus.active;
        }
      }
    });
  }

  void _markActiveStepAsError() {
    final activeIndex = _statuses.indexOf(_StepStatus.active);
    if (activeIndex == -1) return;
    setState(() => _statuses[activeIndex] = _StepStatus.error);
  }

  @override
  Widget build(BuildContext context) {
    final dialog = _buildDialog(context);
    final messengerKey = widget.messengerKey;
    if (messengerKey == null) {
      return dialog;
    }
    return ScaffoldMessenger(
      key: messengerKey,
      child: Scaffold(backgroundColor: Colors.transparent, body: dialog),
    );
  }

  Widget _buildDialog(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.title != null) ...[
                Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
              ],
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < widget.stepLabels.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Marker(
                            variant: MarkerVariant.border,
                            children: [
                              MarkerIcon(child: _statusIcon(_statuses[i])),
                              const SizedBox(width: 8),
                              MarkerContent(child: Text(widget.stepLabels[i])),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        widget.onCancel?.call();
                        Navigator.of(context).pop();
                      },
                      child: Text(t.common.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _completed
                          ? () {
                              widget.onComplete?.call(widget.stepContext);
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: Text(t.common.confirm),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusIcon(_StepStatus status) => switch (status) {
    _StepStatus.pending => const SizedBox.shrink(),
    _StepStatus.active => const CircularProgressIndicator(strokeWidth: 2),
    _StepStatus.done => Icon(Icons.check, color: Theme.of(context).colorScheme.primary, size: 16),
    _StepStatus.error => Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 16),
  };
}
