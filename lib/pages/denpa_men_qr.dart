import 'package:cuid2/cuid2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/denpa_men_session_providers.dart';
import '../routing/app_router.dart';
import 'denpa_men_editor.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/scaffold/app_scaffold.dart';

class DenpaMenQrPageArgs {
  const DenpaMenQrPageArgs({required this.masterData, this.initialRawValue});

  final MasterData masterData;
  final String? initialRawValue;
}

/// Shown before [DenpaMenEditor] when adding individuals: generates a cuid
/// for the current session's QR code and carries it forward once "next" is
/// pressed. Backing out discards the session entirely.
class DenpaMenQrPage extends ConsumerStatefulWidget {
  const DenpaMenQrPage({
    super.key,
    required this.masterData,
    this.initialRawValue,
  });

  final MasterData masterData;
  final String? initialRawValue;

  @override
  ConsumerState<DenpaMenQrPage> createState() => _DenpaMenQrPageState();
}

class _DenpaMenQrPageState extends ConsumerState<DenpaMenQrPage> {
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final denpaMenRecords =
            ref.read(denpaMenListProvider(widget.masterData)).value ?? [];
        final existingDenpaMenCount = denpaMenRecords
            .where((r) => r.denpaMen.parentIds.isEmpty)
            .length;
        ref
            .read(denpaMenSessionProvider.notifier)
            .start(
              widget.initialRawValue ?? cuid(),
              existingDenpaMenCount: existingDenpaMenCount,
            );
      }
    });
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  /// Handles the "R" key to regenerate the QR code, ignoring the key while
  /// the name field has focus so typing "r" there is not intercepted.
  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.keyR &&
        FocusManager.instance.primaryFocus != _nameFocusNode) {
      _regenerate();
      return true;
    }
    return false;
  }

  void _regenerate() {
    ref.read(denpaMenSessionProvider.notifier).regenerateCuid(cuid());
  }

  void _onNameChanged(String value) {
    ref
        .read(denpaMenSessionProvider.notifier)
        .setName(value.isEmpty ? null : value);
  }

  void _next() {
    AddDenpaMenRoute(
      $extra: DenpaMenEditorArgs(
        masterData: widget.masterData,
        sessionMode: true,
      ),
    ).push(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final session = ref.watch(denpaMenSessionProvider);
    final rawValue = session?.cuid;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(denpaMenSessionProvider.notifier).clear();
        }
      },
      child: AppScaffold(
        title: OutlinedTitleText(text: t.page.addDenpaMenGroup),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: rawValue == null ? null : _next,
          label: Text(t.common.next),
        ),
        body: Center(
          child: rawValue == null
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    QrImageView(data: rawValue, size: 240),
                    const SizedBox(height: 16),
                    Text(rawValue),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 240,
                      child: TextField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: rawValue,
                          labelText: t.editableStatus.qrCodeName,
                        ),
                        onChanged: _onNameChanged,
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: _regenerate,
                      child: Text(t.page.qrRegenerate),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
