import 'package:api_client/api_client.dart';
import 'package:denpamemo_logics/denpamemo_logics.dart' as rust;

import '../data/physique_table/objectbox_evasion_rate_category_cache_repository.dart';
import '../data/physique_table/objectbox_physique_table_cache_repository.dart';
import '../data/server/physique_table_args.dart';
import '../widgets/physique_table/physique_table_row.dart';

/// Identifies a physique and builds its "matching location" grid, trying
/// `modules/server` first and falling back to a local computation (via
/// `denpamemo_logics`'s domain-agnostic Rust engine, over the raw table
/// rows and category legend already cached in [tableCacheRepository]/
/// [categoryCacheRepository]) when the server is unreachable. Unlike
/// `_fetchWithCacheFallback` in `physiques_providers.dart` — which
/// replays a previously cached *result* — the fallback here recomputes
/// the result from cached *inputs*, since a search result depends on the
/// caller's own hp/evasionRate and can't be cached ahead of time.
class PhysiqueIdentificationService {
  PhysiqueIdentificationService({
    required this.apiClient,
    required this.tableCacheRepository,
    required this.categoryCacheRepository,
    this.engine = const rust.StatusMatchingEngine(),
    this.timeout = const Duration(seconds: 5),
  });

  final PhysiquesApiClient apiClient;
  final PhysiqueTableCacheRepository tableCacheRepository;
  final EvasionRateCategoryCacheRepository categoryCacheRepository;
  final rust.StatusMatchingEngine engine;
  final Duration timeout;

  /// Mirrors [PhysiquesApiClient.search]. The offline fallback only runs
  /// when [anntenaCategory] is given directly: resolving an [antenna] id
  /// to its `anntenaCategory` (`resolveAntennaCategory` on the server)
  /// depends on translation data this app does not also cache locally,
  /// so that resolution still requires the server.
  Future<PhysiqueSearchResult> search({
    String type = 'evasionRate',
    String against = 'hp',
    required int evasionRate,
    required int hp,
    String? level,
    String? anntenaCategory,
    String? antenna,
  }) async {
    try {
      return await apiClient
          .search(
            type: type,
            against: against,
            evasionRate: evasionRate,
            hp: hp,
            level: level,
            anntenaCategory: anntenaCategory,
            antenna: antenna,
          )
          .timeout(timeout);
    } catch (error) {
      if (anntenaCategory == null || level == null) rethrow;
      return _searchLocally(
        level: level,
        anntenaCategory: anntenaCategory,
        evasionRate: evasionRate,
        hp: hp,
      );
    }
  }

  /// Mirrors [PhysiquesApiClient.legendGrid].
  Future<LegendGridResult> legendGrid(LegendGridRequest request) async {
    try {
      return await apiClient.legendGrid(request).timeout(timeout);
    } catch (_) {
      return _legendGridLocally(request);
    }
  }

  PhysiqueSearchResult _searchLocally({
    required String level,
    required String anntenaCategory,
    required int evasionRate,
    required int hp,
  }) {
    final evasionRateRows = tableCacheRepository.rowsFor(
      PhysiqueTableArgs(type: 'evasionRate', level: level, anntenaCategory: anntenaCategory),
    );
    final hpRows = tableCacheRepository.rowsFor(
      PhysiqueTableArgs(type: 'hp', level: level, anntenaCategory: anntenaCategory),
    );
    final categories = categoryCacheRepository.cachedCategories() ?? const [];

    final rustMatches = engine.findMatchingColumns(
      primary: rust.StatusCriterion(
        rows: [for (final row in evasionRateRows) _toRustRow(row, level: level, anntenaCategory: anntenaCategory)],
        targetValue: evasionRate,
      ),
      others: [
        rust.StatusCriterion(
          rows: [for (final row in hpRows) _toRustRow(row, level: level, anntenaCategory: anntenaCategory)],
          targetValue: hp,
        ),
      ],
    );

    final rustCategories = [for (final category in categories) _toRustCategory(category)];

    final matches = [
      for (final match in rustMatches)
        PhysiqueColumnMatch(
          level: level,
          anntenaCategory: anntenaCategory,
          lineOffset: match.lineOffset,
          columnIndex: match.columnIndex,
          candidates: [
            for (final candidate in engine.resolveCategories(
              categories: rustCategories,
              value: evasionRate,
              columnIndex: match.columnIndex,
            ))
              PhysiqueCategoryCandidate(
                textKey: candidate.categoryKey,
                sign: _toApiSign(candidate.tag),
                evasionRateStart: candidate.rangeStart,
                evasionRateEnd: candidate.rangeEnd,
              ),
          ],
        ),
    ];

    return PhysiqueSearchResult(matches: matches);
  }

  LegendGridResult _legendGridLocally(LegendGridRequest request) {
    final evasionRateRows = tableCacheRepository.rowsFor(
      PhysiqueTableArgs(type: 'evasionRate', level: request.level, anntenaCategory: request.anntenaCategory),
    );
    final hpRows = tableCacheRepository.rowsFor(
      PhysiqueTableArgs(type: 'hp', level: request.level, anntenaCategory: request.anntenaCategory),
    );
    final categories = categoryCacheRepository.cachedCategories() ?? const [];

    final grid = engine.buildCategoryGrid(
      rust.CategoryGridRequest(
        categories: [for (final category in categories) _toRustCategory(category)],
        primaryRows: [
          for (final row in evasionRateRows) _toRustRow(row, level: request.level, anntenaCategory: request.anntenaCategory),
        ],
        companionRows: [
          for (final row in hpRows) _toRustRow(row, level: request.level, anntenaCategory: request.anntenaCategory),
        ],
        matchColumnIndex: request.matchColumnIndex,
        matchLineOffset: request.matchLineOffset,
        matchValue: request.matchEvasionRate,
      ),
    );

    return LegendGridResult(
      level: request.level,
      anntenaCategory: request.anntenaCategory,
      legendCells: [
        for (final cell in grid.categoryCells)
          LegendCell(
            categoryId: cell.categoryId,
            evasionRateStart: cell.rangeStart,
            evasionRateEnd: cell.rangeEnd,
            columnIndex: cell.columnIndex,
            textKey: cell.categoryKey,
            sign: _toApiSign(cell.tag),
            liveValues: cell.liveValues,
            isMatch: cell.isMatch,
          ),
      ],
      hpCells: [
        for (final cell in grid.valueCells)
          HpCell(columnIndex: cell.columnIndex, lineOffset: cell.lineOffset, value: cell.value, isMatch: cell.isMatch),
      ],
    );
  }

  rust.TableRow _toRustRow(PhysiqueTableRow row, {required String level, required String anntenaCategory}) =>
      rust.TableRow(
        group: [level, anntenaCategory],
        lineOffset: row.lineOffset,
        values: [for (final value in row.values) int.tryParse(value)],
      );

  rust.RangeCategory _toRustCategory(PhysiqueEvasionRateCategoryRow row) => rust.RangeCategory(
    id: row.id,
    rangeStart: row.evasionRateStart,
    rangeEnd: row.evasionRateEnd,
    columnIndex: row.columnIndex,
    categoryKey: row.textKey,
    tag: row.sign?.name,
  );

  EvasionRateSign? _toApiSign(String? tag) => tag == null ? null : EvasionRateSign.values.byName(tag);
}
