import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/master_data/anntena.dart';
import '../domain/master_data/antenna_display_name.dart';
import '../domain/master_data/head_shape.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/master_data_providers.dart';
import '../providers/search_providers.dart';
import '../routing/app_router.dart';
import '../widgets/color/color_dot.dart';
import '../widgets/dialog/antenna_selection_dialog.dart';
import '../widgets/dialog/body_color_selection_dialog.dart';
import '../widgets/dialog/head_shape_selection_dialog.dart';
import '../widgets/dialog/master_data_error_listener.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/progress_bar.dart';
import '../widgets/scaffold/app_scaffold.dart';
import '../widgets/search/search_stat_grid.dart';
import '../widgets/unfocus_on_tap.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterDataAsync = ref.watch(masterDataProvider);
    final t = context.t;

    listenForMasterDataErrors(ref, context);

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.search),
      body: masterDataAsync.when(
        data: (masterData) => _SearchForm(
          headShapes: masterData.headShapes,
          anntenas: masterData.anntenas,
        ),
        loading: () => const ProgressBar(),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => const SearchResultsRoute().push(context),
        child: const Icon(Icons.search),
      ),
    );
  }
}

class _SearchForm extends ConsumerStatefulWidget {
  const _SearchForm({required this.headShapes, required this.anntenas});

  final List<HeadShape> headShapes;
  final List<Anntena> anntenas;

  @override
  ConsumerState<_SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends ConsumerState<_SearchForm> {
  late final _nameController = TextEditingController(
    text: ref.read(searchQueryProvider).name,
  );
  late final _memoController = TextEditingController(
    text: ref.read(searchQueryProvider).memo,
  );

  @override
  void dispose() {
    _nameController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final query = ref.watch(searchQueryProvider);
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
            onChanged: (value) => ref
                .read(searchQueryProvider.notifier)
                .update((q) => q.copyWith(name: value)),
          ),
          SearchStatGrid(
            query: query,
            columns: 1,
            onChanged: (value) =>
                ref.read(searchQueryProvider.notifier).state = value,
          ),
          UnfocusOnTap(
            onTap: () async {
              final selected = await showHeadShapeSelectionDialog(
                context,
                headShapes: headShapes,
                selected: headShapes.firstWhere(
                  (h) => h.id == query.headShapeId,
                  orElse: () => headShapes.first,
                ),
              );
              if (selected != null) {
                ref
                    .read(searchQueryProvider.notifier)
                    .update((q) => q.copyWith(headShapeId: selected.id));
              }
            },
            child: ListTile(
              title: Text(t.editableStatus.headShape),
              subtitle: Text(
                query.headShapeId == null
                    ? t.common.unset
                    : t.headShape[query.headShapeId] ?? query.headShapeId!,
              ),
              trailing: query.headShapeId == null
                  ? const Icon(Icons.chevron_right)
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => ref
                          .read(searchQueryProvider.notifier)
                          .update((q) => q.copyWith(headShapeId: null)),
                    ),
            ),
          ),
          UnfocusOnTap(
            onTap: () async {
              final result = await showBodyColorSelectionDialog(
                context,
                selected: query.bodyColors,
                isSpColor: query.isSpColor ?? false,
              );
              if (result != null) {
                ref.read(searchQueryProvider.notifier).update(
                  (q) => q.copyWith(
                    bodyColors: result.bodyColors,
                    isSpColor: result.isSpColor,
                  ),
                );
              }
            },
            child: ListTile(
              title: Text(t.editableStatus.bodyColor),
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
              trailing: query.bodyColors.isEmpty
                  ? const Icon(Icons.chevron_right)
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => ref
                          .read(searchQueryProvider.notifier)
                          .update(
                            (q) => q.copyWith(
                              bodyColors: const [],
                              isSpColor: null,
                            ),
                          ),
                    ),
            ),
          ),
          UnfocusOnTap(
            onTap: () async {
              final result = await showAntennaSelectionDialog(
                context,
                anntenas: anntenas,
                selected: anntenas.firstWhere(
                  (a) => a.id == query.antennaId,
                  orElse: () => anntenas.first,
                ),
                level: query.minAntennaLevel ?? 0,
              );
              if (result != null) {
                ref.read(searchQueryProvider.notifier).update(
                  (q) => q.copyWith(
                    antennaId: result.anntena.id,
                    minAntennaLevel: result.level,
                  ),
                );
              }
            },
            child: ListTile(
              title: Text(t.editableStatus.antenna),
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
              trailing: query.antennaId == null
                  ? const Icon(Icons.chevron_right)
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => ref
                          .read(searchQueryProvider.notifier)
                          .update(
                            (q) => q.copyWith(
                              antennaId: null,
                              minAntennaLevel: null,
                            ),
                          ),
                    ),
            ),
          ),
          TextField(
            controller: _memoController,
            decoration: InputDecoration(labelText: t.editableStatus.memo),
            maxLines: 3,
            onChanged: (value) => ref
                .read(searchQueryProvider.notifier)
                .update((q) => q.copyWith(memo: value)),
          ),
        ],
      ),
    );
  }
}
