import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:denpa_memo/widgets.dart' hide Translations, t;
import '../../providers/denpa_men_icon_providers.dart';

/// [DenpaMenListTile] for [denpaMen], resolving its icon via
/// [denpaMenIconProvider] itself — the single place every "pick/display a
/// DenpaMen from a list" screen should build a tile from, so none of them
/// has to remember to watch the icon provider on its own.
class DenpaMenListTileCell extends ConsumerWidget {
  const DenpaMenListTileCell({
    super.key,
    required this.denpaMen,
    this.selectionMode = false,
    this.selected = false,
    this.onSelectedChanged,
    this.onTap,
    this.enableLongPressPreview = true,
    this.actionMenuItemsBuilder,
  });

  final DenpaMen denpaMen;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool>? onSelectedChanged;
  final VoidCallback? onTap;
  final bool enableLongPressPreview;
  final List<PopupMenuEntry<VoidCallback>> Function(BuildContext)?
  actionMenuItemsBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconFile = ref.watch(denpaMenIconProvider(denpaMen.id)).value;
    return DenpaMenListTile(
      denpaMen: denpaMen,
      selectionMode: selectionMode,
      selected: selected,
      onSelectedChanged: onSelectedChanged,
      onTap: onTap,
      enableLongPressPreview: enableLongPressPreview,
      iconFile: iconFile,
      actionMenuItemsBuilder: actionMenuItemsBuilder,
    );
  }
}
