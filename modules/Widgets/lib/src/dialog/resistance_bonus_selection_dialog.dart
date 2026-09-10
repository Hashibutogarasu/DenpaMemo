import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../list/selectable_list_item_tile.dart';
import 'app_dialog.dart';

/// A single selectable entry in a [ResistanceBonusSelectionDialog]: an id
/// (an [Attribute.id] or an abnormality id) paired with its already
/// localized display label.
typedef ResistanceBonusOption = ({String id, String label});

/// Result of [showResistanceBonusSelectionDialog]: the free-text name the
/// user gave this bundle of user-added resistance bonuses, and the chosen
/// ids mapped to their (always positive) bonus value.
typedef ResistanceBonusSelectionResult = ({
  String name,
  Map<String, int> values,
});

/// Shows an [AlertDialog] letting the user name a bundle of user-added
/// resistance bonuses (attribute or abnormality, depending on [options]),
/// toggle any number of [options] on, and adjust each selected entry's
/// bonus with a 0-9 slider. Mirrors `BodyColorSelectionDialog`'s
/// "toggle, then adjust the selected ones" shape.
Future<ResistanceBonusSelectionResult?> showResistanceBonusSelectionDialog(
  BuildContext context, {
  required String title,
  required List<ResistanceBonusOption> options,
  required Map<String, int> initialValues,
  required String initialName,
}) {
  return AppDialog.show<ResistanceBonusSelectionResult>(
    context: context,
    builder: (context) => ResistanceBonusSelectionDialog(
      title: title,
      options: options,
      initialValues: initialValues,
      initialName: initialName,
    ),
  );
}

class ResistanceBonusSelectionDialog extends StatefulWidget {
  const ResistanceBonusSelectionDialog({
    super.key,
    required this.title,
    required this.options,
    required this.initialValues,
    required this.initialName,
  });

  final String title;
  final List<ResistanceBonusOption> options;
  final Map<String, int> initialValues;
  final String initialName;

  @override
  State<ResistanceBonusSelectionDialog> createState() =>
      _ResistanceBonusSelectionDialogState();
}

class _ResistanceBonusSelectionDialogState
    extends State<ResistanceBonusSelectionDialog> {
  late final TextEditingController _nameController = TextEditingController(
    text: widget.initialName,
  );
  late final Map<String, int> _values = Map.of(widget.initialValues);

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _toggle(String id) {
    setState(() {
      if (_values.containsKey(id)) {
        _values.remove(id);
      } else {
        _values[id] = 1;
      }
    });
  }

  void _setValue(String id, int value) {
    setState(() => _values[id] = value);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: t.editableStatus.correctionName,
                ),
              ),
              const SizedBox(height: 8),
              for (final option in widget.options)
                SelectableListItemTile(
                  label: option.label,
                  selected: _values.containsKey(option.id),
                  onTap: () => _toggle(option.id),
                ),
              if (_values.isNotEmpty) const Divider(),
              for (final option in widget.options)
                if (_values.containsKey(option.id))
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(option.label),
                    subtitle: Slider(
                      value: _values[option.id]!.toDouble(),
                      min: 0,
                      max: 9,
                      divisions: 9,
                      label: '+${_values[option.id]}',
                      onChanged: (value) => _setValue(option.id, value.round()),
                    ),
                    trailing: Text('+${_values[option.id]}'),
                  ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(
            context,
          ).pop((name: _nameController.text.trim(), values: _values)),
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
