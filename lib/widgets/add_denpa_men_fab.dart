import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../i18n/gen/strings.g.dart';
import '../pages/denpa_men_editor.dart';
import '../pages/denpa_men_qr.dart';
import '../routing/app_router.dart';
import 'fab/mini_fab_option.dart';

/// Home screen's add button: a plus [FloatingActionButton] that, when
/// tapped, morphs into a close icon and reveals two mini FABs stacked above
/// it for "add a single individual" and "add via the QR-code group flow".
class AddDenpaMenFab extends StatefulWidget {
  const AddDenpaMenFab({
    super.key,
    required this.masterData,
    this.onImport,
    this.onExport,
    this.animationDuration = const Duration(milliseconds: 200),
    this.mainButtonLayerLink,
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

  final Duration animationDuration;

  @override
  State<AddDenpaMenFab> createState() => _AddDenpaMenFabState();
}

class _AddDenpaMenFabState extends State<AddDenpaMenFab> {
  bool _open = false;
  late final _mainButtonLayerLink = widget.mainButtonLayerLink ?? LayerLink();

  void _toggle() => setState(() => _open = !_open);

  void _import() {
    setState(() => _open = false);
    widget.onImport!();
  }

  void _export() {
    setState(() => _open = false);
    widget.onExport!();
  }

  void _addSingle() {
    setState(() => _open = false);
    AddDenpaMenRoute(
      $extra: DenpaMenEditorArgs(masterData: widget.masterData),
    ).push(context);
  }

  void _addFromQr() {
    setState(() => _open = false);
    DenpaMenQrRoute(
      $extra: DenpaMenQrPageArgs(masterData: widget.masterData),
    ).push(context);
  }

  void _addFromExistingQr() {
    setState(() => _open = false);
    QrCodeSelectionRoute($extra: widget.masterData).push(context);
  }

  Future<void> _addFromQrFile() async {
    setState(() => _open = false);
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
            animationDuration: widget.animationDuration,
          ),
        if (widget.onImport != null)
          MiniFabOption(
            label: t.home.importFromFile,
            icon: Icons.file_upload,
            onPressed: _import,
            open: _open,
            animationDuration: widget.animationDuration,
          ),
        MiniFabOption(
          label: t.home.addFromExistingQr,
          icon: Icons.qr_code_scanner,
          onPressed: _addFromExistingQr,
          open: _open,
          animationDuration: widget.animationDuration,
        ),
        MiniFabOption(
          label: t.home.addFromQrFile,
          icon: Icons.upload_file,
          onPressed: _addFromQrFile,
          open: _open,
          animationDuration: widget.animationDuration,
        ),
        MiniFabOption(
          label: t.home.addFromQr,
          icon: Icons.qr_code,
          onPressed: _addFromQr,
          open: _open,
          animationDuration: widget.animationDuration,
        ),
        MiniFabOption(
          label: t.home.addSingle,
          icon: Icons.person_add,
          onPressed: _addSingle,
          open: _open,
          animationDuration: widget.animationDuration,
        ),
        CompositedTransformTarget(
          link: _mainButtonLayerLink,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: _toggle,
            child: AnimatedRotation(
              duration: widget.animationDuration,
              turns: _open ? 0.125 : 0,
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
