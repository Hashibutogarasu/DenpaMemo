import 'package:api_client/api_client.dart';
import 'package:denpamemo_logics/denpamemo_logics.dart' as rust;

import '../data/physique_table/objectbox_evasion_rate_category_cache_repository.dart';
import '../data/physique_table/objectbox_physique_table_cache_repository.dart';
import '../data/server/physique_table_args.dart';
import 'physique_identification_service.dart'
    show PhysiqueIdentificationService;
import 'physique_rust_mapping.dart';

/// Builds the "matching location" grid for one identification result,
/// from [tableCacheRepository]/[categoryCacheRepository] via
/// `denpamemo_logics`'s domain-agnostic Rust engine — a display-only
/// concern, kept separate from [PhysiqueIdentificationService]'s search.
/// Never talks to `modules/server` itself: `appInitializationProvider` is
/// what keeps these caches fresh.
class PhysiqueLegendGridService {
  const PhysiqueLegendGridService({
    required this.tableCacheRepository,
    required this.categoryCacheRepository,
    required this.awaitInitialSync,
    this.engine = const rust.StatusMatchingEngine(),
  });

  final PhysiqueTableCacheRepository tableCacheRepository;
  final EvasionRateCategoryCacheRepository categoryCacheRepository;
  final Future<void> Function() awaitInitialSync;
  final rust.StatusMatchingEngine engine;

  Future<LegendGridResult> legendGrid(LegendGridRequest request) async {
    try {
      await awaitInitialSync();
    } catch (_) {}

    final primaryRows = tableCacheRepository.rowsFor(
      PhysiqueTableArgs(
        type: PhysiqueIdentificationService.defaultPrimaryType,
        level: request.level,
        anntenaCategory: request.anntenaCategory,
      ),
    );
    final companionRows = tableCacheRepository.rowsFor(
      PhysiqueTableArgs(
        type: PhysiqueIdentificationService.defaultCompanionType,
        level: request.level,
        anntenaCategory: request.anntenaCategory,
      ),
    );
    final categories = categoryCacheRepository.cachedCategories() ?? const [];

    final grid = engine.buildCategoryGrid(
      rust.CategoryGridRequest(
        categories: [
          for (final category in categories) toRustCategory(category),
        ],
        primaryRows: [
          for (final row in primaryRows)
            toRustRow(
              row,
              level: request.level,
              anntenaCategory: request.anntenaCategory,
            ),
        ],
        companionRows: [
          for (final row in companionRows)
            toRustRow(
              row,
              level: request.level,
              anntenaCategory: request.anntenaCategory,
            ),
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
            sign: toApiSign(cell.tag),
            liveValues: cell.liveValues,
            isMatch: cell.isMatch,
          ),
      ],
      hpCells: [
        for (final cell in grid.valueCells)
          HpCell(
            columnIndex: cell.columnIndex,
            lineOffset: cell.lineOffset,
            value: cell.value,
            isMatch: cell.isMatch,
          ),
      ],
    );
  }
}
