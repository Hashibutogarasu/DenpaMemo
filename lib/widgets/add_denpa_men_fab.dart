import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';
import '../pages/denpa_men_editor.dart';
import '../pages/denpa_men_qr.dart';
import '../routing/app_router.dart';

/// Home screen's add button: a plus [FloatingActionButton] that, when
/// tapped, morphs into a close icon and reveals two mini FABs stacked above
/// it for "add a single individual" and "add via the QR-code group flow".
class AddDenpaMenFab extends StatefulWidget {
  const AddDenpaMenFab({
    super.key,
    required this.masterData,
    this.onImport,
    this.onExport,
    this.animationDuration,
    this.mainButtonLayerLink,
    this.expansionController,
  });

  final MasterData masterData;

  /// Lets a caller elsewhere in the tree find exactly where the always-on
  /// "+" button renders (via [CompositedTransformFollower]), regardless of
  /// how much space the mini options above it reserve while closed.
  final LayerLink? mainButtonLayerLink;

  /// When set (mobile home screen, where the AppBar overflow menu is
  /// hidden), a "import from file" option is shown in the expanded menu.
  /// Left null on desktop, where import is reached from the overflow menu.
  final VoidCallback? onImport;

  /// When set (mobile home screen with a non-empty selection), an "export
  /// selected" option is shown in the expanded menu. Left null on desktop
  /// or when nothing is selected.
  final VoidCallback? onExport;

  /// Defaults to [FabButtonThemeData.mainButtonAnimationDuration].
  final Duration? animationDuration;

  /// Lets a caller elsewhere in the tree (e.g. [AppScaffold], to show a
  /// dimmed backdrop behind this FAB while it's expanded) observe and
  /// control whether the menu is open. When left null, this widget owns
  /// its open/closed state privately, same as before this existed.
  final ValueNotifier<bool>? expansionController;

  @override
  State<AddDenpaMenFab> createState() => _AddDenpaMenFabState();
}

class _AddDenpaMenFabState extends State<AddDenpaMenFab> {
  late final ValueNotifier<bool> _expansion =
      widget.expansionController ?? ValueNotifier(false);
  late final bool _ownsExpansion = widget.expansionController == null;
  late final _mainButtonLayerLink = widget.mainButtonLayerLink ?? LayerLink();

  bool get _open => _expansion.value;

  @override
  void initState() {
    super.initState();
    _expansion.addListener(_handleExpansionChanged);
  }

  @override
  void dispose() {
    _expansion.removeListener(_handleExpansionChanged);
    if (_ownsExpansion) {
      _expansion.dispose();
    }
    super.dispose();
  }

  void _handleExpansionChanged() => setState(() {});

  void _toggle() => _expansion.value = !_expansion.value;

  void _import() {
    _expansion.value = false;
    widget.onImport!();
  }

  void _export() {
    _expansion.value = false;
    widget.onExport!();
  }

  void _addSingle() {
    _expansion.value = false;
    AddDenpaMenRoute(
      $extra: DenpaMenEditorArgs(masterData: widget.masterData),
    ).push(context);
  }

  void _addFromQr() {
    _expansion.value = false;
    DenpaMenQrRoute(
      $extra: DenpaMenQrPageArgs(masterData: widget.masterData),
    ).push(context);
  }

  void _addFromExistingQr() {
    _expansion.value = false;
    QrCodeSelectionRoute($extra: widget.masterData).push(context);
  }

  Future<void> _addFromQrFile() async {
    _expansion.value = false;
    final result = await FilePicker.pickFiles(type: FileType.image);
    final pickedPath = result?.files.single.path;
    if (pickedPath == null) {
      return;
    }
    final bytes = await File(pickedPath).readAsBytes();
    final rawValue = decodeQrCodeImage(bytes);
    if (!mounted) {
      return;
    }
    if (rawValue == null) {
      final t = context.t;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.home.addFromQrFileInvalid)));
      return;
    }
    DenpaMenQrRoute(
      $extra: DenpaMenQrPageArgs(
        masterData: widget.masterData,
        initialRawValue: rawValue,
      ),
    ).push(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final fabTheme = Theme.of(context).extension<FabButtonThemeData>()!;
    final animationDuration =
        widget.animationDuration ?? fabTheme.mainButtonAnimationDuration;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.onExport != null)
          MiniFabOption(
            label: t.home.exportSelected,
            icon: Icons.ios_share,
            onPressed: _export,
            open: _open,
            animationDuration: animationDuration,
          ),
        if (widget.onImport != null)
          MiniFabOption(
            label: t.home.importFromFile,
            icon: Icons.file_upload,
            onPressed: _import,
            open: _open,
            animationDuration: animationDuration,
          ),
        MiniFabOption(
          label: t.home.addFromExistingQr,
          icon: Icons.qr_code_scanner,
          onPressed: _addFromExistingQr,
          open: _open,
          animationDuration: animationDuration,
        ),
        MiniFabOption(
          label: t.home.addFromQrFile,
          icon: Icons.upload_file,
          onPressed: _addFromQrFile,
          open: _open,
          animationDuration: animationDuration,
        ),
        MiniFabOption(
          label: t.home.addFromQr,
          icon: Icons.qr_code,
          onPressed: _addFromQr,
          open: _open,
          animationDuration: animationDuration,
        ),
        MiniFabOption(
          label: t.home.addSingle,
          icon: Icons.person_add,
          onPressed: _addSingle,
          open: _open,
          animationDuration: animationDuration,
        ),
        CompositedTransformTarget(
          link: _mainButtonLayerLink,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: _toggle,
            child: AnimatedRotation(
              duration: animationDuration,
              turns: _open ? 0.125 : 0,
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
