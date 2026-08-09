import 'package:flutter/material.dart';

import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../pages/denpa_men_editor.dart';
import '../routing/app_router.dart';

/// Home screen's add button: a plus [FloatingActionButton] that, when
/// tapped, morphs into a close icon and reveals two mini FABs stacked above
/// it for "add a single individual" and "add via the QR-code group flow".
class AddDenpaMenFab extends StatefulWidget {
  const AddDenpaMenFab({
    super.key,
    required this.masterData,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  final MasterData masterData;
  final Duration animationDuration;

  @override
  State<AddDenpaMenFab> createState() => _AddDenpaMenFabState();
}

class _AddDenpaMenFabState extends State<AddDenpaMenFab> {
  bool _open = false;

  void _toggle() => setState(() => _open = !_open);

  void _addSingle() {
    setState(() => _open = false);
    AddDenpaMenRoute(
      $extra: DenpaMenEditorArgs(masterData: widget.masterData),
    ).push(context);
  }

  void _addFromQr() {
    setState(() => _open = false);
    DenpaMenQrRoute($extra: widget.masterData).push(context);
  }

  void _addFromExistingQr() {
    setState(() => _open = false);
    QrCodeSelectionRoute($extra: widget.masterData).push(context);
  }

  Widget _miniOption({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IgnorePointer(
      ignoring: !_open,
      child: AnimatedSlide(
        duration: widget.animationDuration,
        curve: Curves.easeOutCubic,
        offset: _open ? Offset.zero : const Offset(0, 0.3),
        child: AnimatedOpacity(
          duration: widget.animationDuration,
          curve: Curves.easeOutCubic,
          opacity: _open ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: onPressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(label),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton.small(
                  heroTag: null,
                  onPressed: onPressed,
                  child: Icon(icon),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _miniOption(
          label: t.home.addFromExistingQr,
          icon: Icons.qr_code_scanner,
          onPressed: _addFromExistingQr,
        ),
        _miniOption(
          label: t.home.addFromQr,
          icon: Icons.qr_code,
          onPressed: _addFromQr,
        ),
        _miniOption(
          label: t.home.addSingle,
          icon: Icons.person_add,
          onPressed: _addSingle,
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: _toggle,
          child: AnimatedRotation(
            duration: widget.animationDuration,
            turns: _open ? 0.125 : 0,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
