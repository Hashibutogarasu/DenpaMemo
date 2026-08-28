import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../color/color_dot.dart';
import '../dialog/antenna_selection_dialog.dart';
import '../dialog/body_color_selection_dialog.dart';
import '../dialog/head_shape_selection_dialog.dart';
import '../domain/antenna_display_name.dart';
import '../../i18n/gen/strings.g.dart';
import 'search_filter_tile.dart';
import 'search_stat_grid.dart';

/// The filter form for [query], shared by the search page and any other
/// flow that needs the same filters (e.g. the individual-selection page's
/// search tab). Every edit is reported through [onChanged] with a new
/// draft query.
class SearchForm extends StatefulWidget {
  const SearchForm({
    super.key,
    required this.headShapes,
    required this.anntenas,
    required this.query,
    required this.onChanged,
  });

  final List<HeadShape> headShapes;
  final List<Anntena> anntenas;
  final DenpaMenSearchQuery query;
  final ValueChanged<DenpaMenSearchQuery> onChanged;

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  late final _nameController = TextEditingController(text: widget.query.name);
  late final _memoController = TextEditingController(text: widget.query.memo);

  void _update(
    DenpaMenSearchQuery Function(DenpaMenSearchQuery query) update,
  ) {
    widget.onChanged(update(widget.query));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final query = widget.query;
    final headShapes = widget.headShapes;
    final anntenas = widget.anntenas;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: t.search.name),
            onChanged: (value) => _update((q) => q.copyWith(name: value)),
          ),
          SearchStatGrid(
            query: query,
            columns: 1,
            onChanged: widget.onChanged,
          ),
          SearchFilterTile<HeadShape>(
            label: t.editableStatus.headShape,
            isSet: query.headShapeId != null,
            subtitle: Text(
              query.headShapeId == null
                  ? t.common.unset
                  : t.headShape[query.headShapeId] ?? query.headShapeId!,
            ),
            openDialog: (context) => showHeadShapeSelectionDialog(
              context,
              headShapes: headShapes,
              selected: headShapes.firstWhere(
                (h) => h.id == query.headShapeId,
                orElse: () => headShapes.first,
              ),
            ),
            onApply: (selected) =>
                _update((q) => q.copyWith(headShapeId: selected.id)),
            onClear: () => _update((q) => q.copyWith(headShapeId: null)),
          ),
          SearchFilterTile<BodyColorSelectionResult>(
            label: t.editableStatus.bodyColor,
            isSet: query.bodyColors.isNotEmpty,
            subtitle: query.bodyColors.isEmpty
                ? Text(t.common.unset)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final colorId in query.bodyColors)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: ColorDot(colorId: colorId),
                        ),
                    ],
                  ),
            openDialog: (context) => showBodyColorSelectionDialog(
              context,
              selected: query.bodyColors,
              isSpColor: query.isSpColor ?? false,
            ),
            onApply: (result) => _update(
              (q) => q.copyWith(
                bodyColors: result.bodyColors,
                isSpColor: result.isSpColor,
              ),
            ),
            onClear: () =>
                _update((q) => q.copyWith(bodyColors: const [], isSpColor: null)),
          ),
          SearchFilterTile<AntennaSelectionResult>(
            label: t.editableStatus.antenna,
            isSet: query.antennaId != null,
            subtitle: Text(
              query.antennaId == null
                  ? t.common.unset
                  : antennaDisplayName(
                      t,
                      anntenas.firstWhere(
                        (a) => a.id == query.antennaId,
                        orElse: () => anntenas.first,
                      ),
                      query.minAntennaLevel ?? 0,
                    ),
            ),
            openDialog: (context) => showAntennaSelectionDialog(
              context,
              anntenas: anntenas,
              selected: anntenas.firstWhere(
                (a) => a.id == query.antennaId,
                orElse: () => anntenas.first,
              ),
              level: query.minAntennaLevel ?? 0,
            ),
            onApply: (result) => _update(
              (q) => q.copyWith(
                antennaId: result.anntena.id,
                minAntennaLevel: result.level,
              ),
            ),
            onClear: () =>
                _update((q) => q.copyWith(antennaId: null, minAntennaLevel: null)),
          ),
          TextField(
            controller: _memoController,
            decoration: InputDecoration(labelText: t.editableStatus.memo),
            maxLines: 3,
            onChanged: (value) => _update((q) => q.copyWith(memo: value)),
          ),
        ],
      ),
    );
  }
}
