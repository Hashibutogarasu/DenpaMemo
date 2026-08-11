import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../domain/master_data/master_data.dart';
import '../domain/qr_code/qr_code_image_decoder.dart';
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
