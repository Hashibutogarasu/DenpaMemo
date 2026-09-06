import 'package:api_client/api_client.dart';
import 'package:denpamemo_logics/denpamemo_logics.dart' as rust;

import '../data/physique_table/objectbox_evasion_rate_category_cache_repository.dart';
import '../data/physique_table/objectbox_physique_table_cache_repository.dart';
import '../data/server/physique_table_args.dart';
import 'physique_antenna_category_resolver.dart';
import 'physique_rust_mapping.dart';

/// Identifies a physique from [tableCacheRepository]/[categoryCacheRepository]
/// via `denpamemo_logics`'s domain-agnostic Rust engine. Never talks to
/// `modules/server` itself: `appInitializationProvider` is what keeps
/// these caches fresh, so this always reads whatever they currently
/// hold, online or not, rather than branching on reachability itself.
/// [awaitInitialSync] is awaited before every read, so a search made
/// right after launch (before that first sync settles) still sees the
/// caches it populates — the splash screen is purely time-based and
/// never waits for it itself.
class PhysiqueIdentificationService {
  const PhysiqueIdentificationService({
    required this.tableCacheRepository,
    required this.categoryCacheRepository,
    required this.antennaCategoryResolver,
    required this.awaitInitialSync,
    this.engine = const rust.StatusMatchingEngine(),
  });

  static const defaultPrimaryType = 'evasionRate';
  static const defaultCompanionType = 'hp';

  final PhysiqueTableCacheRepository tableCacheRepository;
  final EvasionRateCategoryCacheRepository categoryCacheRepository;
  final PhysiqueAntennaCategoryResolver antennaCategoryResolver;
  final Future<void> Function() awaitInitialSync;
  final rust.StatusMatchingEngine engine;

  Future<PhysiqueSearchResult> search({
    String type = defaultPrimaryType,
    String against = defaultCompanionType,
    required int evasionRate,
    required int hp,
    String? level,
    String? anntenaCategory,
    String? antenna,
  }) async {
    try {
      await awaitInitialSync();
    } catch (_) {}

    final resolvedCategory =
        anntenaCategory ??
        (antenna == null ? null : antennaCategoryResolver.resolve(antenna));
    if (resolvedCategory == null || level == null) {
      throw StateError(
        'Cannot identify a physique: no cached anntenaCategory for level/antenna.',
      );
    }

    final primaryRows = tableCacheRepository.rowsFor(
      PhysiqueTableArgs(
        type: type,
        level: level,
        anntenaCategory: resolvedCategory,
      ),
    );
    final companionRows = tableCacheRepository.rowsFor(
      PhysiqueTableArgs(
        type: against,
        level: level,
        anntenaCategory: resolvedCategory,
      ),
    );
    final categories = categoryCacheRepository.cachedCategories() ?? const [];
    final rustCategories = [
      for (final category in categories) toRustCategory(category),
    ];

    final rustMatches = engine.findMatchingColumns(
      primary: rust.StatusCriterion(
        rows: [
          for (final row in primaryRows)
            toRustRow(row, level: level, anntenaCategory: resolvedCategory),
        ],
        targetValue: evasionRate,
      ),
      others: [
        rust.StatusCriterion(
          rows: [
            for (final row in companionRows)
              toRustRow(row, level: level, anntenaCategory: resolvedCategory),
          ],
          targetValue: hp,
        ),
      ],
    );

    return PhysiqueSearchResult(
      matches: [
        for (final match in rustMatches)
          PhysiqueColumnMatch(
            level: level,
            anntenaCategory: resolvedCategory,
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
                  sign: toApiSign(candidate.tag),
                  evasionRateStart: candidate.rangeStart,
                  evasionRateEnd: candidate.rangeEnd,
                ),
            ],
          ),
      ],
    );
  }
}
