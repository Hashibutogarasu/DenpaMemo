import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/master_data/antenna_display_name.dart';
import '../../i18n/gen/strings.g.dart';
import '../../providers/search_providers.dart';
import 'search_filter_tile.dart';

/// The filter form bound to [searchFormDraftProvider], shared by the search
/// page and any other flow that needs the same filters (e.g. the
/// individual-selection page's search tab).
class SearchForm extends ConsumerStatefulWidget {
  const SearchForm({super.key, required this.headShapes, required this.anntenas});

  final List<HeadShape> headShapes;
  final List<Anntena> anntenas;

  @override
  ConsumerState<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends ConsumerState<SearchForm> {
  late final _nameController = TextEditingController(
    text: ref.read(searchFormDraftProvider).name,
  );
  late final _memoController = TextEditingController(
    text: ref.read(searchFormDraftProvider).memo,
  );

  void _update(
    DenpaMenSearchQuery Function(DenpaMenSearchQuery query) update,
  ) {
    ref.read(searchFormDraftProvider.notifier).update(update);
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
    final query = ref.watch(searchFormDraftProvider);
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
            onChanged: (value) =>
                ref.read(searchFormDraftProvider.notifier).state = value,
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
            apply: (q, selected) => q.copyWith(headShapeId: selected.id),
            clear: (q) => q.copyWith(headShapeId: null),
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
            apply: (q, result) => q.copyWith(
              bodyColors: result.bodyColors,
              isSpColor: result.isSpColor,
            ),
            clear: (q) => q.copyWith(bodyColors: const [], isSpColor: null),
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
            apply: (q, result) => q.copyWith(
              antennaId: result.anntena.id,
              minAntennaLevel: result.level,
            ),
            clear: (q) => q.copyWith(antennaId: null, minAntennaLevel: null),
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
